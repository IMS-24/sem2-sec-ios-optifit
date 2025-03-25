import Foundation

extension URLRequest {
    mutating func addAuthorizationHeader(with token: String?) {
        if let token = token {
            self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
