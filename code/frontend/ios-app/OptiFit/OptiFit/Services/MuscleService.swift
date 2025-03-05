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

    func searchMuscles(searchModel: SearchMusclesDto) async throws(ApiError) -> PaginatedResult<GetMuscleDto> {
        guard let url = URL(string: "\(baseURL)/search") else {
            throw .invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(searchModel)
        } catch {
            throw .decodingFailed
        }


        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(PaginatedResult<GetMuscleDto>.self, from: data)
            return response
        } catch {
            throw .requestFailed
        }
    }
}
