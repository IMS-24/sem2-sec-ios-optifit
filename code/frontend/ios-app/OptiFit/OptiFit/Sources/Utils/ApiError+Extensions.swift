import Foundation

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The request URL is invalid.", comment: "")
        case .badRequest(let message):
            return message ?? NSLocalizedString("Bad request. Please check your input and try again.", comment: "")
        case .unauthorized(let message):
            return message ?? NSLocalizedString("You are not authorized to perform this action.", comment: "")
        case .serverError(let message):
            return message ?? NSLocalizedString("The server encountered an error. Please try again later.", comment: "")
        case .requestFailed:
            return NSLocalizedString("The network request failed. Please try again later.", comment: "")
        case .decodingFailed:
            return NSLocalizedString("We were unable to process the server response.", comment: "")
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", comment: "")
        }
    }
}
