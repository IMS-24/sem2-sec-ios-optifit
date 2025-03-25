import Combine
import Foundation
import SwiftUI

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

    func updateExercise(id: UUID, exerciseDto: UpdateExerciseDto) async -> Bool {
        isLoading = true
        errorMessage = nil
        var res = false
        do {
            let updated = try await exerciseService.updateExercise(exerciseId: id, exercise: exerciseDto)
            withAnimation {
                if let index = exercises.firstIndex(where: { $0.id == updated.id }) {
                    exercises[index] = updated
                } else {
                    exercises.append(updated)
                }
            }
            res = true
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
            res = false
        }
        isLoading = false
        return res
    }

    func deleteExercise(exerciseId: UUID) async -> Bool {
        isLoading = true
        errorMessage = nil
        var result = false
        do {
            // Assuming the service returns the id of the deleted exercise

            let deletedId = try await exerciseService.deleteExercise(exerciseId: exerciseId)
            withAnimation {
                if let index = exercises.firstIndex(where: { $0.id == deletedId }) {
                    exercises.remove(at: index)
                }
            }
            result = true
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
        return result
    }

    func searchExercises() async {
        isLoading = true
        errorMessage = nil
        do {
            searchModel.pageIndex = 0
            currentPage = 0
            let res = try await exerciseService.searchExercises(searchModel: searchModel)
            exercises = res.items
            totalPages = res.totalPages

        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func loadMoreExercises() async {
        guard !isLoadingMore, currentPage + 1 < totalPages else {
            return
        }
        isLoadingMore = true
        currentPage += 1
        searchModel.pageIndex = currentPage
        do {
            let res = try await exerciseService.searchExercises(searchModel: searchModel)
            exercises.append(contentsOf: res.items)

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

    func loadStatistics(exerciseId: UUID) async -> GetExerciseStatisticsDto? {
        do {
            let statisticsRes = try await exerciseService.fetchExerciseStatistics(exerciseId: exerciseId)
            return statisticsRes
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
            return nil
        }
    }

    func updateSearchModel(_ newModel: SearchExercisesDto) {
        self.searchModel = newModel
        Task {
            await searchExercises()
        }
    }
}
