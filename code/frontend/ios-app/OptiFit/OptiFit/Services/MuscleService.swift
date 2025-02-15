//
//  MuscleService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 16.02.25.
//

import Foundation

@MainActor
class MuscleService: ObservableObject {
    @Published var muscles: [Muscle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage?

    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/muscle"

    func searchMuscles(searchModel: SearchMusclesDto) async {
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
            errorMessage = ErrorMessage(message: "Failed to encode request")
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            muscles = try decoder.decode([Muscle].self, from: data)
        } catch {
            errorMessage = ErrorMessage(message: "Failed to decode response: \(error.localizedDescription)")
        }

        isLoading = false
    }
}
