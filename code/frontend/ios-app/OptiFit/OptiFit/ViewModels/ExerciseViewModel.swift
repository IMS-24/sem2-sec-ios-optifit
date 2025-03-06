import Foundation
import SwiftUI
import Combine

@MainActor
class ExerciseViewModel: ObservableObject {
    @Published var exercises: [GetExerciseDto] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel = SearchExercisesDto()
    @Published var exerciseCategories: [ExerciseCategoryDto] = []

    // Pagination state
    private var currentPage: Int = 0
    private var totalPages: Int = 1
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false

    private let exerciseService = ExerciseService()

    func saveExercise(exerciseDto: CreateExerciseDto) async {
        isLoading = true
        errorMessage = nil
        do {
            let created = try await exerciseService.postExercise(exerciseDto)
            exercises.append(created)
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
    func deleteExercise(_ id: UUID) async {
        // Begin loading.
        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }
        do {
            // Attempt deletion via the service.
            if try await exerciseService.deleteExercise(exerciseId: id){
                // Remove the deleted exercise from the array.
                exercises.removeAll { $0.id == id }
            }
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }


    func searchExercises() async {
        isLoading = true
        errorMessage = nil
        do {
            // Reset pagination for a new search
            searchModel.pageIndex = 0
            currentPage = 0
            if let res = try await exerciseService.searchExercises(searchModel: searchModel) {
                exercises = res.items
                totalPages = res.totalPages  // update total pages if provided by your API
            }
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func loadMoreExercises() async {
        // Ensure we haven't reached the last page and we're not already loading more
        guard !isLoadingMore, currentPage + 1 < totalPages else {
            return
        }
        isLoadingMore = true
        currentPage += 1
        searchModel.pageIndex = currentPage
        do {
            if let res = try await exerciseService.searchExercises(searchModel: searchModel) {
                // Append the newly fetched exercises to the existing list
                exercises.append(contentsOf: res.items)
            }
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoadingMore = false
    }

    func searchExerciseCategories() async {
        do {
            let exerciseCategoriesRes = try await exerciseService.fetchExerciseCategories()
            exerciseCategories = exerciseCategoriesRes
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func updateSearchModel(_ newModel: SearchExercisesDto) {
        self.searchModel = newModel
        Task {
            await searchExercises()
        }
    }
}
