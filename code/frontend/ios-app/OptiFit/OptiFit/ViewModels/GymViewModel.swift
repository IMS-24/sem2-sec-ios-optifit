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
    @Published var gyms: [Gym] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel: SearchGymsDto = SearchGymsDto()

    private var cancellables = Set<AnyCancellable>()
    private let gymService = GymService()

    init() {
        observeService()
        searchGyms()
    }

    private func observeService() {
        gymService.$gyms
                .sink { [weak self] gyms in
                    self?.gyms = gyms
                }
                .store(in: &cancellables)

        gymService.$errorMessage
                .sink { [weak self] errorMessage in
                    self?.errorMessage = errorMessage
                }
                .store(in: &cancellables)
    }

    func searchGyms() {
        Task {
            await gymService.searchGym(searchModel: searchModel)
        }
    }

    func updateSearchModel(_ newModel: SearchGymsDto) {
        searchModel = newModel
    }
}
