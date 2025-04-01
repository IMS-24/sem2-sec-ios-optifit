import Foundation
import OpenAPIRuntime
import Foundation
import HTTPTypes

extension URLRequest {
    mutating func addAuthorizationHeader(with token: String?) {
        if let token = token {
            self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
extension HTTPRequest {
    mutating func addAuthorizationHeader(with token: String?) {
        if let token = token {
//            self.headerFields?["Authorization"] = "Bearer \(token)"
            self.headerFields[.authorization] = "Bearer \(token)"
        }
    }
}
