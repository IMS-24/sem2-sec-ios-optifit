//
//  MuscleViewModel.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 22.02.25.
//

import Foundation
import Combine

@MainActor
class MuscleViewModel: ObservableObject {
    @Published var muscles: [Muscle] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel = SearchMusclesDto()
    private let muscleService = MuscleService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        observeService()
        searchMuscles()
    }

    private func observeService() {
        muscleService.$muscles
                .sink { [weak self] muscles in
                    self?.muscles = muscles
                }
                .store(in: &cancellables)

        muscleService.$errorMessage
                .sink { [weak self] error in
                    self?.errorMessage = error
                }
                .store(in: &cancellables)
    }

    func searchMuscles() {
        Task {
            await muscleService.searchMuscles(searchModel: searchModel)
        }
    }

    func updateSearchModel(_ newModel: SearchMusclesDto) {
        self.searchModel = newModel
        searchMuscles()
    }
}
