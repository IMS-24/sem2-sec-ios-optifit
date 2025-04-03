import Combine
import Foundation
import SwiftUI

@MainActor
class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Components.Schemas.GetWorkoutDto] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel = Components.Schemas.SearchWorkoutDto()

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
            currentPage = 0
            searchModel.pageIndex = Int32(currentPage)
            searchModel.pageSize = Int32(100)
            let result = try await workoutService.searchWorkouts(searchModel: searchModel)
            workouts = result.items ?? []
            totalPages = (Int)(result.totalPages!)

        } catch {
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
        searchModel.pageIndex = Int32(currentPage)
        do {
            let result = try await workoutService.searchWorkouts(searchModel: searchModel)

            workouts.append(contentsOf: result.items ?? [])

        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)

        }
        isLoadingMore = false
    }

    func saveWorkout(_ workout: Components.Schemas.CreateWorkoutDto) async {
        isLoading = true
        errorMessage = nil
        do {
            let created = try await workoutService.postWorkout(workout)
            workouts.append(created)

        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func appendWorkout(_ workout: Components.Schemas.GetWorkoutDto) {
        self.workouts.append(workout)
    }

    func updateSearchModel(_ newModel: Components.Schemas.SearchWorkoutDto) {
        self.searchModel = newModel
        Task {
            await searchWorkouts()
        }
    }
}
