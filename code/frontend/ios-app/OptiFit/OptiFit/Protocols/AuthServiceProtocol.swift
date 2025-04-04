import MSAL
import SwiftUI
@MainActor
protocol AuthServiceProtocol {
    func persistToken(_ token: String?)
    func retrieveToken() -> String?
    func deleteToken()
    func decodeJWT(_ token: String) throws -> AuthUser?
    func authorize() async throws -> (String, MSALAccount)
    func refreshToken() async throws -> MSALResult
//    func callApi(withToken token: String) async throws -> [String: Any]
    func signOut()
}
