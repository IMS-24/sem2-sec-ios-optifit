//
//  MuscleGroupService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 16.02.25.
//

import Foundation

@MainActor
class MuscleGroupService: ObservableObject {
    @Published var muscleGroups: [MuscleGroup] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage?

    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/musclegroup"

    func searchMuscleGroups(searchModel: SearchMuscleGroupsDto) async {
        guard let url = URL(string: "\(baseURL)/search") else {
            errorMessage = ErrorMessage(message: "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(searchModel)
        } catch {
            errorMessage = ErrorMessage(message: "Failed to encode Request")
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(PaginatedResult<MuscleGroup>.self, from: data)
            muscleGroups = response.items
        } catch {
            errorMessage = ErrorMessage(message: "Failed to decode Response")
        }
        isLoading = false
    }
}
