import SwiftUI
import MSAL

// MARK: - View Model

class AuthViewModel: ObservableObject {
    // Constants
    let kTenantName = "optif1t.onmicrosoft.com"
    let kAuthorityHostName = "optif1t.b2clogin.com"
    let kClientID = "284ae6b3-8bd8-47cb-9ab1-98e74f4441db"
    let kSignupOrSigninPolicy = "b2c_1_susi"
//    let kEditProfilePolicy = "b2c_1_edit_profile" // Uncommented as needed for editing profile
    let kGraphURI = "https://graph.microsoft.com"
    let kScopes: [String] = ["https://optif1t.onmicrosoft.com/4e883ca0-1d29-4a61-ab49-d259b448b564/Profile.Read"]
    // Format: https://<authorityHost>/tfp/<tenant>/<policy>
    let kEndpoint = "https://%@/tfp/%@/%@"
    
    // Published properties for UI binding
    @Published var loggingText: String = ""
    @Published var accessToken: String? = nil
    @Published var signOutEnabled = false
    @Published var callGraphApiEnabled = false
    @Published var editProfileEnabled = false
    @Published var refreshTokenEnabled = false
    
    var application: MSALPublicClientApplication!
    
    init() {
        do {
            let signinAuthority = try getAuthority(forPolicy: kSignupOrSigninPolicy)
//            let editProfileAuthority = try getAuthority(forPolicy: kEditProfilePolicy)
            
            // Configure MSAL with default redirect URI (msal<clientID>://auth)
            let config = MSALPublicClientApplicationConfig(clientId: kClientID,
                                                           redirectUri: nil,
                                                           authority: signinAuthority)
            config.knownAuthorities = [signinAuthority
//                                       , editProfileAuthority
            ]
            self.application = try MSALPublicClientApplication(configuration: config)
            updateLoggingText("MSAL application created successfully.")
        } catch {
            updateLoggingText("Unable to create application: \(error)")
        }
    }
    
    // MARK: - Helper Methods
    
    func updateLoggingText(_ text: String) {
        DispatchQueue.main.async {
            self.loggingText = text
        }
    }
    
    func getAuthority(forPolicy policy: String) throws -> MSALB2CAuthority {
        guard let url = URL(string: String(format: kEndpoint, kAuthorityHostName, kTenantName, policy)) else {
            throw NSError(domain: "SomeDomain", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Unable to create authority URL!"])
        }
        return try MSALB2CAuthority(url: url)
    }
    
    func getAccountByPolicy(withAccounts accounts: [MSALAccount], policy: String) -> MSALAccount? {
        // For a single account sample we check if the homeAccountId's objectId ends with the policy
        for account in accounts {
            if let homeAccountId = account.homeAccountId,
               let objectId = homeAccountId.objectId,
               objectId.hasSuffix(policy.lowercased()) {
                return account
            }
        }
        return nil
    }
    
    // Retrieve the root view controller for presenting authentication
    func getRootViewController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = windowScene.windows.first?.rootViewController else {
            fatalError("No root view controller found")
        }
        return root
    }
    
    // MARK: - Authentication Methods
    
    func authorize() {
        do {
            let authority = try getAuthority(forPolicy: kSignupOrSigninPolicy)
            let webParameters = MSALWebviewParameters(authPresentationViewController: getRootViewController())
            let parameters = MSALInteractiveTokenParameters(scopes: kScopes, webviewParameters: webParameters)
            parameters.promptType = .selectAccount
            parameters.authority = authority
            
            application.acquireToken(with: parameters) { [weak self] result, error in
                guard let self = self else { return }
                if let error = error {
                    self.updateLoggingText("Could not acquire token: \(error)")
                    return
                }
                guard let result = result else {
                    self.updateLoggingText("Could not acquire token: No result returned")
                    return
                }
                self.accessToken = result.accessToken
                self.updateLoggingText("Access token is \(self.accessToken ?? "Empty")")
                DispatchQueue.main.async {
                    self.signOutEnabled = true
                    self.callGraphApiEnabled = true
                    self.editProfileEnabled = true
                    self.refreshTokenEnabled = true
                }
            }
        } catch {
            updateLoggingText("Unable to create authority: \(error)")
        }
    }
    
    func editProfile() {
//        do {
//            guard let authority = try? getAuthority(forPolicy: kEditProfilePolicy),
//                  let account = (try? getAccountByPolicy(withAccounts: application.allAccounts(), policy: kEditProfilePolicy)) ??
//                    (try? getAccountByPolicy(withAccounts: application.allAccounts(), policy: kSignupOrSigninPolicy)) else {
//                updateLoggingText("No account available for editing profile")
//                return
//            }
//            let webParameters = MSALWebviewParameters(authPresentationViewController: getRootViewController())
//            let parameters = MSALInteractiveTokenParameters(scopes: kScopes, webviewParameters: webParameters)
//            parameters.authority = authority
//            parameters.account = account
//            
//            application.acquireToken(with: parameters) { [weak self] result, error in
//                guard let self = self else { return }
//                if let error = error {
//                    self.updateLoggingText("Could not edit profile: \(error)")
//                } else {
//                    self.updateLoggingText("Successfully edited profile")
//                }
//            }
//        } catch {
//            updateLoggingText("Unable to construct parameters before calling acquire token: \(error)")
//        }
    }
    
    func refreshToken() {
//        do {
//            guard let authority = try? getAuthority(forPolicy: kEditProfilePolicy),
//                  let account = (try? getAccountByPolicy(withAccounts: application.allAccounts(), policy: kEditProfilePolicy)) ??
//                    (try? getAccountByPolicy(withAccounts: application.allAccounts(), policy: kSignupOrSigninPolicy)) else {
//                updateLoggingText("No account available for editing profile")
//                return
//            }
//            let parameters = MSALSilentTokenParameters(scopes: kScopes, account: account)
//            parameters.authority = authority
//            
//            application.acquireTokenSilent(with: parameters) { [weak self] result, error in
//                guard let self = self else { return }
//                if let error = error as NSError? {
//                    if error.domain == MSALErrorDomain && error.code == MSALError.interactionRequired.rawValue {
//                        // The refresh token expired or a password change was detected; do interactive re-authentication
//                        let webParameters = MSALWebviewParameters(authPresentationViewController: self.getRootViewController())
//                        let interactiveParameters = MSALInteractiveTokenParameters(scopes: self.kScopes, webviewParameters: webParameters)
//                        interactiveParameters.account = account
//                        self.application.acquireToken(with: interactiveParameters) { result, error in
//                            guard let result = result else {
//                                self.updateLoggingText("Could not acquire new token: \(error?.localizedDescription ?? "No error information")")
//                                return
//                            }
//                            self.accessToken = result.accessToken
//                            self.updateLoggingText("Access token is \(self.accessToken ?? "empty")")
//                        }
//                        return
//                    }
//                    self.updateLoggingText("Could not acquire token: \(error.localizedDescription)")
//                    return
//                }
//                guard let result = result else {
//                    self.updateLoggingText("Could not acquire token: No result returned")
//                    return
//                }
//                self.accessToken = result.accessToken
//                self.updateLoggingText("Refreshing token silently\nRefreshed access token is \(self.accessToken ?? "empty")")
//            }
//        } catch {
//            updateLoggingText("Unable to construct parameters before calling acquire token: \(error)")
//        }
    }
    
    func callApi() {
        guard let token = accessToken else {
            updateLoggingText("Operation failed because could not find an access token!")
            return
        }
        guard let url = URL(string: kGraphURI) else {
            updateLoggingText("Invalid Graph URI")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        updateLoggingText("Calling the API....")
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: .main)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                self.updateLoggingText("Could not call API: \(error)")
                return
            }
            guard let data = data,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                  let jsonDict = jsonObject as? [String: Any] else {
                self.updateLoggingText("Nothing returned from API")
                return
            }
            self.updateLoggingText("API response: \(jsonDict)")
        }.resume()
    }
    
    func signOut() {
        do {
            guard let account = try? getAccountByPolicy(withAccounts: application.allAccounts(), policy: kSignupOrSigninPolicy) else {
                updateLoggingText("There is no account to sign out!")
                return
            }
            try application.remove(account)
            DispatchQueue.main.async {
                self.signOutEnabled = false
                self.callGraphApiEnabled = false
                self.editProfileEnabled = false
                self.refreshTokenEnabled = false
            }
            updateLoggingText("Signed out")
        } catch {
            updateLoggingText("Received error signing out: \(error)")
        }
    }

}

// MARK: - SwiftUI View

struct LoginView: View {
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                Text(viewModel.loggingText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .border(Color.gray)
            .frame(height: 200)
            
            Button("Authorize") {
                viewModel.authorize()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("Edit Profile") {
                viewModel.editProfile()
            }
            .padding()
            .background(viewModel.editProfileEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(!viewModel.editProfileEnabled)
            
            Button("Refresh Token") {
                viewModel.refreshToken()
            }
            .padding()
            .background(viewModel.refreshTokenEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(!viewModel.refreshTokenEnabled)
            
            Button("Call API") {
                viewModel.callApi()
            }
            .padding()
            .background(viewModel.callGraphApiEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(!viewModel.callGraphApiEnabled)
            
            Button("Sign Out") {
                viewModel.signOut()
            }
            .padding()
            .background(viewModel.signOutEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(!viewModel.signOutEnabled)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
