
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
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    private let workoutService = WorkoutService()
    
    
    func searchWorkouts() async {
        isLoading = true
        errorMessage = nil
        do {
            // Reset pagination for a new search
            searchModel.pageIndex = 0
            currentPage = 0
            if let result = try await workoutService.searchWorkouts(searchModel: searchModel) {
                workouts=result.items
                totalPages = result.totalPages
            }
            
        }catch{
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func loadMoreWorkouts() async {
        guard !isLoadingMore, currentPage + 1 < totalPages else {
            return
        }
        isLoadingMore = true
        currentPage += 1
        searchModel.pageIndex = currentPage
        do{
            if let res = try await workoutService.searchWorkouts(searchModel: searchModel)
            {
                workouts.append(contentsOf: res.items)
            }
        }
        catch{
            self.errorMessage = ErrorMessage(message: error.localizedDescription)

        }
        isLoadingMore = false
    }
    func saveWorkout(_ workout:CreateWorkoutDto)async {
        isLoading = true
        errorMessage = nil
        do{
            let created = try await workoutService.postWorkout(workout)
            workouts.append(created)
            
        }catch{
            self.errorMessage=ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func updateSearchModel(_ newModel: SearchWorkoutsDto) {
        self.searchModel = newModel
        Task {
            await searchWorkouts()
        }
    }
}
