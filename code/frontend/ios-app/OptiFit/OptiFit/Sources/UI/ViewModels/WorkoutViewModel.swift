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
    private let workoutService: WorkoutServiceProtocol

    // Dependency injection via initializer.
    init(workoutService: WorkoutServiceProtocol = WorkoutService()) {
        self.workoutService = workoutService
    }

    func searchWorkouts() async {
        isLoading = true
        errorMessage = nil
        do {
            // Capture the service in a local constant to avoid sending self.workoutService across actors
            let service = self.workoutService
            let result = try await service.searchWorkouts(searchModel: searchModel)
            workouts = result.items ?? []
            totalPages = Int(result.totalPages ?? 1)
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
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
