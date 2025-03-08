

import SwiftUI
import MSAL

@MainActor
final class AuthService {
    // MARK: - Constants
    private let tenantName = "optif1t.onmicrosoft.com"
    private let authorityHostName = "optif1t.b2clogin.com"
    private let clientID = "284ae6b3-8bd8-47cb-9ab1-98e74f4441db"
    private let signupOrSigninPolicy = "b2c_1_susi"
    private let editProfilePolicy = "b2c_1_edit_profile"
    private let scopes: [String] = ["https://optif1t.onmicrosoft.com/4e883ca0-1d29-4a61-ab49-d259b448b564/Profile.Read"]
    // URL format: https://<authorityHost>/tfp/<tenant>/<policy>
    private let endpointFormat = "https://%@/tfp/%@/%@"
    private let graphURI = "https://graph.microsoft.com"
    private let service = "net.qb8s.optifit"
    private let account = "jwtToken"
    private var application: MSALPublicClientApplication!
    
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
            print("[+]: MSAL application created successfully.")
        } catch {
            print("[-]: Unable to create MSAL application: \(error)")
        }
    }
    
    private func getAuthority(forPolicy policy: String) throws -> MSALB2CAuthority {
        guard let url = URL(string: String(format: endpointFormat, authorityHostName, tenantName, policy)) else {
            throw NSError(domain: "AuthService", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Unable to create authority URL!"
            ])
        }
        return try MSALB2CAuthority(url: url)
    }
    
    private func getRootViewController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = windowScene.windows.first?.rootViewController else {
            fatalError("[-]: No root view controller found")
        }
        return root
    }
    func persistToken(_ token: String?) {
        if let token = token{
            let _ = KeychainHelper.shared.save(token: token, service: service, account: account)
        }
       
    }
    func retrieveToken() -> String? {
        return KeychainHelper.shared.readToken(service: service, account: account)
    }
    func deleteToken() {
        KeychainHelper.shared.deleteToken(service: service, account: account)
    }
    /// Decodes the JWT token to extract the user information.
    func decodeJWT(_ token: String) throws -> AuthUser? {
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
            throw NSError(domain: "AuthService", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to decode JWT payload"])
        }
        // For debugging, you could print the JSON payload:
        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
           let dict = json as? [String: Any] {
            print("[*]: Decoded JWT payload: \(dict)")
        }
        let user = try JSONDecoder().decode(AuthUser.self, from: data)
        return user
    }
    
    /// Initiates an interactive token acquisition.
    func authorize() async throws -> MSALResult {
        let authority = try getAuthority(forPolicy: signupOrSigninPolicy)
        let webParameters = MSALWebviewParameters(authPresentationViewController: getRootViewController())
        let parameters = MSALInteractiveTokenParameters(scopes: scopes, webviewParameters: webParameters)
        parameters.promptType = .selectAccount
        parameters.authority = authority
        
        let result: MSALResult = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<MSALResult, Error>) in
            application.acquireToken(with: parameters) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let result = result {
                    continuation.resume(returning: result)
                } else {
                    let err = NSError(domain: "AuthService", code: 2, userInfo: [NSLocalizedDescriptionKey: "No result returned"])
                    continuation.resume(throwing: err)
                }
            }
        }
        return result
    }
    
    /// Attempts to acquire a token silently, with interactive fallback.
    func refreshToken() async throws -> MSALResult {
        // Get account based on policy.
        let accounts = try application.allAccounts()
        guard let account = accounts.first(where: { account in
            if let homeAccountId = account.homeAccountId,
               let objectId = homeAccountId.objectId {
                return objectId.hasSuffix(signupOrSigninPolicy.lowercased())
            }
            return false
        }) else {
            throw NSError(domain: "AuthService", code: 4, userInfo: [NSLocalizedDescriptionKey: "No account available for token refresh"])
        }
        
        guard let authority = try? getAuthority(forPolicy: editProfilePolicy) else {
            throw NSError(domain: "AuthService", code: 5, userInfo: [NSLocalizedDescriptionKey: "Unable to create authority for refresh"])
        }
        let silentParameters = MSALSilentTokenParameters(scopes: scopes, account: account)
        silentParameters.authority = authority
        
        do {
            let result: MSALResult = try await withCheckedThrowingContinuation { continuation in
                application.acquireTokenSilent(with: silentParameters) { result, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let result = result {
                        continuation.resume(returning: result)
                    } else {
                        let err = NSError(domain: "AuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "No result returned"])
                        continuation.resume(throwing: err)
                    }
                }
            }
            return result
        } catch {
            // If silent acquisition fails due to interaction requirements, fallback to interactive.
            let nsError = error as NSError
            if nsError.domain == MSALErrorDomain && nsError.code == MSALError.interactionRequired.rawValue {
                let webParameters = MSALWebviewParameters(authPresentationViewController: getRootViewController())
                let interactiveParameters = MSALInteractiveTokenParameters(scopes: scopes, webviewParameters: webParameters)
                interactiveParameters.account = account
                let interactiveResult: MSALResult = try await withCheckedThrowingContinuation { continuation in
                    application.acquireToken(with: interactiveParameters) { result, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else if let result = result {
                            continuation.resume(returning: result)
                        } else {
                            let err = NSError(domain: "AuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "No result returned"])
                            continuation.resume(throwing: err)
                        }
                    }
                }
                return interactiveResult
            } else {
                throw error
            }
        }
    }
    
    // MARK: - API Call
    func callApi(withToken token: String) async throws -> [String: Any] {
        guard let url = URL(string: graphURI) else {
            throw NSError(domain: "AuthService", code: 7, userInfo: [NSLocalizedDescriptionKey: "Invalid Graph URI"])
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
           let jsonDict = jsonObject as? [String: Any] {
            return jsonDict
        } else {
            return [:]
        }
    }
    
    func signOut() {
        // For now, simply print a message.
        print("[+]: Sign out called on AuthService")
    }
}

