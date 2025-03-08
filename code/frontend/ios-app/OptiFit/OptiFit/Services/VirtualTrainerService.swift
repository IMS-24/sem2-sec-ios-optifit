//
//  VirtualTrainerService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//

import Foundation
@MainActor
class VirtualTrainerService: ObservableObject{
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/virtualtrainer"
    let service = "net.qb8s.optifit"  // A unique identifier for your service
    let account = "jwtToken"                 // Key under which the token is stored
    func fetchMotivation(level: Int) async throws (ApiError)-> InsultDto {
        guard let url = URL(string: "\(baseURL)/motivation/\(level)")
        else {
            throw .invalidURL
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addAuthorizationHeader(with: token)
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
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let insultResult = try decoder.decode(InsultDto.self, from: data)
            return insultResult
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
        }
    }
}
struct InsultDto: Codable {
    let level: Int
    let message: String
}


