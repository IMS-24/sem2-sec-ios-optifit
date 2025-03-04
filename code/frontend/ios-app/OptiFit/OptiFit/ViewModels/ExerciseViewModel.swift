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
    @Published  var isLoading:Bool = false

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
    func searchExercises() async {
        isLoading = true
        errorMessage = nil
        do{
            // Reset pagination for a new search
            searchModel.pageIndex = 0
            currentPage = 0
            let res = try await exerciseService.searchExercises(searchModel: searchModel)
            exercises = res!.items
            }
        
            catch{
                self.errorMessage = ErrorMessage(message: error.localizedDescription)
            }
            isLoading = false
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
//    func loadMoreExercises() async {
//        guard !isLoadingMore, currentPage + 1 < totalPages else {
//            return
//        }
//        isLoadingMore = true
//        currentPage += 1
//        searchModel.pageIndex = currentPage
//        _ = await exerciseService.searchExercises(searchModel: searchModel, append: true)
//        isLoadingMore = false
//    }

    func updateSearchModel(_ newModel: SearchExercisesDto) {
        self.searchModel = newModel
        Task {
            await searchExercises()
        }
    }
}
