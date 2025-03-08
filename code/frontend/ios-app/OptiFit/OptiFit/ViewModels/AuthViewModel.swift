import SwiftUI
import MSAL

@MainActor
final class AuthViewModel: ObservableObject {
    // MARK: - Constants
    private let tenantName = "optif1t.onmicrosoft.com"
    private let authorityHostName = "optif1t.b2clogin.com"
    private let clientID = "284ae6b3-8bd8-47cb-9ab1-98e74f4441db"
    private let signupOrSigninPolicy = "b2c_1_susi"
    private let editProfilePolicy = "b2c_1_edit_profile"
    private let graphURI = "https://graph.microsoft.com"
    private let scopes: [String] = ["https://optif1t.onmicrosoft.com/4e883ca0-1d29-4a61-ab49-d259b448b564/Profile.Read"]
    // URL format: https://<authorityHost>/tfp/<tenant>/<policy>
    private let endpointFormat = "https://%@/tfp/%@/%@"
    
    // MARK: - Published Properties
    @Published var loggingText: String = ""
    @Published var accessToken: String? = nil
    @Published var user: AuthUser? = nil
    @Published var signOutEnabled = false
    @Published var callGraphApiEnabled = false
    @Published var editProfileEnabled = false
    @Published var refreshTokenEnabled = false
    @Published var currentAccount: MSALAccount? = nil
    @Published var initUserProfile: UserProfileInitializeDto? = nil

//    @Published var profile:UserProfileDto? = nil
    @EnvironmentObject private var userProfileViewModel: UserProfileViewModel
    
    
   
    let service = "net.qb8s.optifit"  // A unique identifier for your service
    let account = "jwtToken"                 // Key under which the token is stored
    
    
    
    
    // MSAL application instance
    private var application: MSALPublicClientApplication!
    
    // MARK: - Initialization
    init() {
        do {
            let signinAuthority = try getAuthority(forPolicy: signupOrSigninPolicy)
            let config = MSALPublicClientApplicationConfig(
                clientId: clientID,
                redirectUri: nil,
                authority: signinAuthority
            )
            config.knownAuthorities = [signinAuthority]
            self.application = try MSALPublicClientApplication(configuration: config)
            
            updateLoggingText("MSAL application created successfully.")
        } catch {
            updateLoggingText("Unable to create application: \(error)")
        }
    }
    
    // MARK: - Helper Methods
    private func updateLoggingText(_ text: String) {
        loggingText = text
    }
    
    private func getAuthority(forPolicy policy: String) throws -> MSALB2CAuthority {
        guard let url = URL(string: String(format: endpointFormat, authorityHostName, tenantName, policy)) else {
            throw NSError(domain: "AuthViewModel", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Unable to create authority URL!"
            ])
        }
        return try MSALB2CAuthority(url: url)
    }
    
    private func getAccount(byPolicy policy: String, from accounts: [MSALAccount]) -> MSALAccount? {
        for account in accounts {
            if let homeAccountId = account.homeAccountId,
               let objectId = homeAccountId.objectId,
               objectId.hasSuffix(policy.lowercased()) {
                return account
            }
        }
        return nil
    }
    
    private func getRootViewController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = windowScene.windows.first?.rootViewController else {
            fatalError("No root view controller found")
        }
        return root
    }
    
    /// Decodes the JWT access token to extract the user information.
    private func decodeJWT(_ token: String) throws -> AuthUser? {
        let segments = token.split(separator: ".")
        guard segments.count > 1 else { return nil }
        var base64String = String(segments[1])
        base64String = base64String.replacingOccurrences(of: "-", with: "+")
        base64String = base64String.replacingOccurrences(of: "_", with: "/")
        let requiredLength = 4 * ((base64String.count + 3) / 4)
        let paddingLength = requiredLength - base64String.count
        if paddingLength > 0 {
            base64String += String(repeating: "=", count: paddingLength)
        }
        guard let data = Data(base64Encoded: base64String) else {
            throw NSError(domain: "AuthViewModel", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to decode JWT payload"])
        }
        // For debugging, print the JSON payload:
        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
           let dict = json as? [String: Any] {
            print("Decoded JWT payload: \(dict)")
        }
        let user = try JSONDecoder().decode(AuthUser.self, from: data)
        return user
    }

    func isLoggedIn()->Bool{
        return self.user != nil || self.accessToken != nil
    }
    ///https://learn.microsoft.com/en-us/entra/identity-platform/tutorial-mobile-app-ios-swift-sign-in?pivots=workforce
    
    /// Initiates an interactive token acquisition using async/await.
    func authorize() async {
        do {
            let authority = try getAuthority(forPolicy: signupOrSigninPolicy)
            let webParameters = MSALWebviewParameters(authPresentationViewController: getRootViewController())
            let parameters = MSALInteractiveTokenParameters(scopes: scopes, webviewParameters: webParameters)
            parameters.promptType = .selectAccount
            parameters.authority = authority
            
            let result: MSALResult = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<MSALResult, Error>) in
                self.application.acquireToken(with: parameters) { result, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let result = result {
                        continuation.resume(returning: result)
                    } else {
                        let error = NSError(domain: "AuthViewModel", code: 2, userInfo: [NSLocalizedDescriptionKey: "No result returned"])
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            accessToken = result.accessToken
            currentAccount = result.account  // Save the account here
            updateLoggingText("Access token is \(accessToken ?? "Empty")")
            let success = KeychainHelper.shared.save(token: accessToken ?? "Empty", service: service, account: account)
            if success {
                print("Token saved successfully!")
            } else {
                print("Failed to save token.")
            }
            // Attempt to decode the JWT to populate the user object.
            do {
                self.user = try self.decodeJWT(result.accessToken)
                if let user = self.user {
                    self.user?.firstLogin = true
                    
                    let userProfile = UserProfileInitializeDto(
                        firstName: user.given_name ?? "No",
                        lastName: user.family_name ?? "Lastname",
                        oId: user.id,
                        email: user.emails?.first ?? "No@email.com",
                        dateOfBirthUtc: nil)
                    self.initUserProfile = userProfile
                }
                
                
            } catch {
                updateLoggingText("Failed to decode JWT: \(error.localizedDescription)")
            }
            
            signOutEnabled = true
            callGraphApiEnabled = true
            editProfileEnabled = true
            refreshTokenEnabled = true
        } catch {
            updateLoggingText("Could not acquire token: \(error)")
        }
    }
    
    func editProfile() async {
        // Implementation for editing profile (if needed) goes here.
    }
    
    func refreshToken() async {
        do {
            // Try to obtain authority and account using editProfilePolicy if available, or fallback.
            guard let authority = try? getAuthority(forPolicy: editProfilePolicy),
                  let account = (try? getAccount(byPolicy: signupOrSigninPolicy, from: application.allAccounts())) else {
                updateLoggingText("No account available for editing profile")
                return
            }
            
            let silentParameters = MSALSilentTokenParameters(scopes: scopes, account: account)
            silentParameters.authority = authority
            
            do {
                // Attempt to acquire token silently.
                let silentResult: MSALResult = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<MSALResult, Error>) in
                    application.acquireTokenSilent(with: silentParameters) { result, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else if let result = result {
                            continuation.resume(returning: result)
                        } else {
                            let err = NSError(domain: "AuthViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "No result returned"])
                            continuation.resume(throwing: err)
                        }
                    }
                }
                self.accessToken = silentResult.accessToken
                updateLoggingText("Refreshing token silently\nRefreshed access token is \(self.accessToken ?? "empty")")
            } catch {
                // If the silent token call fails due to interaction requirement, fallback to interactive.
                let nsError = error as NSError
                if nsError.domain == MSALErrorDomain && nsError.code == MSALError.interactionRequired.rawValue {
                    let webParameters = MSALWebviewParameters(authPresentationViewController: self.getRootViewController())
                    let interactiveParameters = MSALInteractiveTokenParameters(scopes: scopes, webviewParameters: webParameters)
                    interactiveParameters.account = account
                    do {
                        let interactiveResult: MSALResult = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<MSALResult, Error>) in
                            application.acquireToken(with: interactiveParameters) { result, error in
                                if let error = error {
                                    continuation.resume(throwing: error)
                                } else if let result = result {
                                    continuation.resume(returning: result)
                                } else {
                                    let err = NSError(domain: "AuthViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "No result returned"])
                                    continuation.resume(throwing: err)
                                }
                            }
                        }
                        self.accessToken = interactiveResult.accessToken
                        updateLoggingText("Access token is \(self.accessToken ?? "empty")")
                    } catch {
                        updateLoggingText("Could not acquire new token interactively: \(error.localizedDescription)")
                    }
                } else {
                    updateLoggingText("Could not acquire token silently: \(error.localizedDescription)")
                }
            }
        } catch {
            updateLoggingText("Unable to construct parameters before calling acquire token: \(error)")
        }
    }
    
    /// Calls the Graph API using async/await.
    func callApi() async {
        guard let token = accessToken else {
            updateLoggingText("Operation failed because no access token was found!")
            return
        }
        guard let url = URL(string: graphURI) else {
            updateLoggingText("Invalid Graph URI")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        updateLoggingText("Calling the API...")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let jsonDict = jsonObject as? [String: Any] {
                updateLoggingText("API response: \(jsonDict)")
            } else {
                updateLoggingText("Nothing returned from API")
            }
        } catch {
            updateLoggingText("Could not call API: \(error)")
        }
    }
    
    /// Signs out the current user.
    func signOut() {
//        do {
//            guard let account = currentAccount else {
//                updateLoggingText("No account available to sign out!")
//                return
//            }
//            try application.remove(account)
            currentAccount = nil
            signOutEnabled = false
            callGraphApiEnabled = false
            editProfileEnabled = false
            refreshTokenEnabled = false
        accessToken = nil
        user = nil
        
            updateLoggingText("Signed out")
//        } catch {
//            updateLoggingText("Error signing out: \(error)")
//        }
    }
}
