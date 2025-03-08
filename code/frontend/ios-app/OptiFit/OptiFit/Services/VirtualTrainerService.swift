//
//  VirtualTrainerService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//

import Foundation
@MainActor
class VirtualTrainerService: ObservableObject{
    private let baseURL = "virtualtrainer"
    private let apiClient: APIClient = APIClient()

    func fetchMotivation(level: Int) async throws -> InsultDto {
        return try await apiClient.request(endpoint: "\(baseURL)/motivation/\(level)", method: .init("GET"))
       
    }
}


