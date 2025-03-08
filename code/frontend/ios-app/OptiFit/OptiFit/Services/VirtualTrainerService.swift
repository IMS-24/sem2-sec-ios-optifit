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
    
    func fetchMotivation(token:String,level: Int) async throws (ApiError)-> InsultDto {
        guard let url = URL(string: "\(baseURL)/motivation/\(level)")
        else {
            throw .invalidURL
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addAuthorizationHeader(with: token)
            let (data, _) = try await URLSession.shared.data(for: request)
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


