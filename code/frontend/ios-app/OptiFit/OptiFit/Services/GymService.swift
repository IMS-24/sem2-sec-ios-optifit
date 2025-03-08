//
//  GymService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import Foundation

@MainActor
class GymService: ObservableObject {
    
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/gym"
    
    func searchGym(searchModel: SearchGymsDto, token: String) async throws (ApiError)->PaginatedResult<GetGymDto> {
        guard let url = URL(string: "\(baseURL)/search")
        else {
            throw .invalidURL
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
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(PaginatedResult<GetGymDto>.self, from: data)
            
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
            
        }
    }
}
