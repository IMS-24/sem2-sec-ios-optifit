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
    @Published var muscles: [GetMuscleDto] = []
    @Published var searchModel = SearchMusclesDto(pageSize: 10, pageIndex: 0)
    private let muscleService = MuscleService()
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage?


    func searchMuscles() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await muscleService.searchMuscles(searchModel: searchModel)
            muscles = response.items
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func updateSearchModel(_ newModel: SearchMusclesDto) async {
        self.searchModel = newModel
        await searchMuscles()
    }
}
