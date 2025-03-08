//
//  GymService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import Foundation

@MainActor
class GymService: ObservableObject {
    private let apiClient: APIClient = APIClient()

    private let baseURL = "gym"
    
    func searchGym(searchModel: SearchGymsDto) async throws ->PaginatedResult<GetGymDto> {
        return try await apiClient.request(endpoint: "\(baseURL)/search",method: .init("POST"),body: searchModel)
    }
        
}
