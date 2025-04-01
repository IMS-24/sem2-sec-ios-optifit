import MSAL
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var loggingText: String = ""
    @Published var accessToken: String? = nil
    @Published var user: AuthUser? = nil
    @Published var signOutEnabled: Bool = false
    @Published var callGraphApiEnabled: Bool = false
    @Published var editProfileEnabled: Bool = false
    @Published var refreshTokenEnabled: Bool = false
    @Published var currentAccount: MSALAccount? = nil
    @Published var initUserProfile: Components.Schemas.InitializeUserProfileDto? = nil

    private let authService = AuthService()

    func authorize() async {
        do {
            let result = try await authService.authorize()
            accessToken = result.accessToken
            currentAccount = result.account
            updateLoggingText("Access token is \(accessToken ?? "Empty")")

            authService.persistToken(accessToken)
            do {
                self.user = try authService.decodeJWT(result.accessToken)
                if var user = self.user {
                    user.firstLogin = true
                    let userProfile = Components.Schemas.InitializeUserProfileDto(
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

    func refreshToken() async {
        do {
            let result = try await authService.refreshToken()
            accessToken = result.accessToken
            updateLoggingText("Refreshed access token is \(accessToken ?? "empty")")
        } catch {
            updateLoggingText("Could not refresh token: \(error.localizedDescription)")
        }
    }

    func callApi() async {
        guard let token = accessToken else {
            updateLoggingText("Operation failed because no access token was found!")
            return
        }
        updateLoggingText("Calling the API...")
        do {
            let response = try await authService.callApi(withToken: token)
            updateLoggingText("API response: \(response)")
        } catch {
            updateLoggingText("Could not call API: \(error)")
        }
    }

    func signOut() {
        currentAccount = nil
        signOutEnabled = false
        callGraphApiEnabled = false
        editProfileEnabled = false
        refreshTokenEnabled = false
        accessToken = nil
        user = nil
        updateLoggingText("Signed out")
        authService.deleteToken()
        authService.signOut()
    }

    // MARK: - Helper Method
    private func updateLoggingText(_ text: String) {
        loggingText = text
    }
}
