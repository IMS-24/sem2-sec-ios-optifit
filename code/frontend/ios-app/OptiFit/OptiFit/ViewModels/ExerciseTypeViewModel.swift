//
//  ExerciseTypeViewModel.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation
import Combine

@MainActor
class ExerciseTypeViewModel: ObservableObject {
    @Published var exerciseTypes: [ExerciseCategory] = []
    @Published var errorMessage: ErrorMessage?

    private let exerciseService = ExerciseService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        observeService()
        fetchExerciseTypes()
    }

    private func observeService() {
        exerciseService.$exerciseTypes
                .sink { [weak self] in
                    self?.exerciseTypes = $0
                }
                .store(in: &cancellables)

        exerciseService.$errorMessage
                .sink { [weak self] in
                    self?.errorMessage = $0
                }
                .store(in: &cancellables)
    }

    func fetchExerciseTypes() {
        Task {
            await exerciseService.fetchExerciseCategories()
        }
    }
}
