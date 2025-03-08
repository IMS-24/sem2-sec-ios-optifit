//
//  MuscleService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 16.02.25.
//

import Foundation

@MainActor
class MuscleService: ObservableObject {
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/muscle"
    let service = "net.qb8s.optifit"  // A unique identifier for your service
    let account = "jwtToken"                 // Key under which the token is stored
    
    func searchMuscles(searchModel: SearchMusclesDto) async throws (ApiError) -> PaginatedResult<GetMuscleDto> {
        guard let url = URL(string: "\(baseURL)/search")
        else {
            throw .invalidURL
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addAuthorizationHeader(with: token)
        do {
            request.httpBody = try JSONEncoder().encode(searchModel)
            
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
            return try decoder.decode(PaginatedResult<GetMuscleDto>.self, from: data)
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
            
        }
    }
}
