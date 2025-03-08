
import Foundation
class APIClient {
    let service = "net.qb8s.optifit"  // A unique identifier for your service
    let account = "jwtToken"                 // Key under which the token is stored
    
    
    func request<Input: Encodable, Output: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Input? = nil
    ) async throws -> Output {
        guard let url = URL(string: "\(Configuration.apiBaseURL.absoluteString)/\(endpoint)") else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw ApiError.unauthorized("No token found")
        }
            request.addAuthorizationHeader(with: token)
        
        
        if let body = body {
            let encoder = ISO8601CustomCoder.makeEncoder()
            request.httpBody = try encoder.encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 400:
                throw ApiError.badRequest(String(data: data, encoding: .utf8))
            case 401:
                throw ApiError.unauthorized(String(data: data, encoding: .utf8))
            case 500:
                throw ApiError.serverError(String(data: data, encoding: .utf8))
            default:
                throw ApiError.requestFailed
            }
        }
        
        let decoder = ISO8601CustomCoder.makeDecoder()
        return try decoder.decode(Output.self, from: data)
    }
}
extension APIClient {
    func request<Output: Decodable>(
        endpoint: String,
        method: String = "GET"
    ) async throws -> Output {
        try await request(endpoint: endpoint, method: method, body: Optional<Empty>.none)
    }
}
struct Empty: Encodable {}
