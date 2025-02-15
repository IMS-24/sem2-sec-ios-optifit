//
//  GymService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import Foundation

@MainActor
class GymService: ObservableObject {
    @Published var gyms: [Gym] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage?

    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/gym"

    func searchGym(searchModel: SearchGymsDto) async {
        guard let url = URL(string: "\(baseURL)/search") else {
            self.errorMessage = ErrorMessage(message: "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(searchModel)
        } catch {
            self.errorMessage = ErrorMessage(message: "Failed to encode search request")
            return
        }

        self.isLoading = true
        self.errorMessage = nil

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(PaginatedResult<Gym>.self, from: data)
            self.gyms = response.items
        } catch {
            self.errorMessage = ErrorMessage(message: "Network or decoding error: \(error.localizedDescription)")
        }

        self.isLoading = false
    }
}
