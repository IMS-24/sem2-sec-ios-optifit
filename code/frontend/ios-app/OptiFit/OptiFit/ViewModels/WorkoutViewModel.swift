
import Foundation
import SwiftUI
import Combine

@MainActor
class WorkoutViewModel: ObservableObject {
    @Published var workouts: [GetWorkoutDto] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel = SearchWorkoutsDto()
    
    // Pagination state
    private var currentPage: Int = 0
    private var totalPages: Int = 1
    private var isLoadingMore: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let workoutService = WorkoutService()
    
    init() {
        observeService()
        Task {
            await searchWorkouts()
        }
    }
    
    private func observeService() {
        workoutService.$workouts
            .sink { [weak self] in
                self?.workouts = $0
            }
            .store(in: &cancellables)
        
        workoutService.$errorMessage
            .sink { [weak self] in
                self?.errorMessage = $0
            }
            .store(in: &cancellables)
    }
    
    func searchWorkouts() async {
        // Reset pagination for a new search
        searchModel.pageIndex = 0
        currentPage = 0
        if let result = await workoutService.searchWorkouts(searchModel: searchModel, append: false) {
            totalPages = result.totalPages
        }
    }
    
    func loadMoreWorkouts() async {
        guard !isLoadingMore, currentPage + 1 < totalPages else {
            return
        }
        isLoadingMore = true
        currentPage += 1
        searchModel.pageIndex = currentPage
        _ = await workoutService.searchWorkouts(searchModel: searchModel, append: true)
        isLoadingMore = false
    }
    
    func updateSearchModel(_ newModel: SearchWorkoutsDto) {
        self.searchModel = newModel
        Task {
            await searchWorkouts()
        }
    }
}
