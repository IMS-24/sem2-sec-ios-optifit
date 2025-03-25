import Foundation

class APIClient {
    let service = "net.qb8s.optifit"
    let account = "jwtToken"

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
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else {
            throw ApiError.unauthorized("No token found")
        }
        request.addAuthorizationHeader(with: token)

        if let body = body {
            let encoder = ISO8601CustomCoder.makeEncoder()
            request.httpBody = try encoder.encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        // Response logging: log URL, status code, and body
        if let httpResponse = response as? HTTPURLResponse {
            let responseBody = String(data: data, encoding: .utf8) ?? "Unable to decode response body"
            print("[Response Logging] URL: \(url.absoluteString)")
            print("[Response Logging] Status Code: \(httpResponse.statusCode)")
            print("[Response Logging] Response Body: \(responseBody)")
        } else {
            print("[Response Logging] Non HTTPURLResponse received for URL: \(url.absoluteString)")
        }
        
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
