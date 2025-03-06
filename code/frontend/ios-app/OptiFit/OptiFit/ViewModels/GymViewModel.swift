//
//  GymViewModel.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import Foundation
import Combine

@MainActor
class GymViewModel: ObservableObject {
    @Published var gyms: [GetGymDto] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel: SearchGymsDto = SearchGymsDto()
    @Published var isLoading: Bool = false
    private let gymService = GymService()


    func searchGyms() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await gymService.searchGym(searchModel: searchModel)
            gyms = response.items
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func updateSearchModel(_ newModel: SearchGymsDto) {
        searchModel = newModel
    }
}
