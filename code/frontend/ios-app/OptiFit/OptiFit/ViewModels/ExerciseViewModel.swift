import Foundation
import SwiftUI
import Combine

@MainActor
class ExerciseViewModel: ObservableObject {
    @Published var exercises: [GetExerciseDto] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel = SearchExercisesDto()

    // Pagination state
    private var currentPage: Int = 0
    private var totalPages: Int = 1
    private var isLoadingMore: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let exerciseService = ExerciseService()

    init() {
        observeService()
        Task {
            await searchExercises()
        }
    }

    private func observeService() {
        exerciseService.$exercises
                .sink { [weak self] in
                    self?.exercises = $0
                }
                .store(in: &cancellables)

        exerciseService.$errorMessage
                .sink { [weak self] in
                    self?.errorMessage = $0
                }
                .store(in: &cancellables)
    }

    func searchExercises() async {
        // Reset pagination for a new search
        searchModel.pageIndex = 0
        currentPage = 0
        if let result = await exerciseService.searchExercises(searchModel: searchModel, append: false) {
            totalPages = result.totalPages
        }
    }

    func loadMoreExercises() async {
        guard !isLoadingMore, currentPage + 1 < totalPages else {
            return
        }
        isLoadingMore = true
        currentPage += 1
        searchModel.pageIndex = currentPage
        _ = await exerciseService.searchExercises(searchModel: searchModel, append: true)
        isLoadingMore = false
    }

    func updateSearchModel(_ newModel: SearchExercisesDto) {
        self.searchModel = newModel
        Task {
            await searchExercises()
        }
    }
}
