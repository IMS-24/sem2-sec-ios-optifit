
enum ApiError: Error {
    case invalidURL
    case badRequest(String?)
    case unauthorized(String?)
    case serverError(String?)
    case requestFailed
    case decodingFailed
    case unknown
}
