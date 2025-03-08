//
//  MuscleService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 16.02.25.
//

import Foundation

@MainActor
class MuscleService: ObservableObject {
    private let baseURL = "muscle"
    private let apiClient: APIClient = APIClient()

    
    func searchMuscles(searchModel: SearchMusclesDto) async throws -> PaginatedResult<GetMuscleDto> {
        return try await apiClient.request(endpoint: "\(baseURL)/search",method:.init("POST"),body:searchModel)
    }
}
