import Foundation
import Combine

@MainActor
class ExerciseCategoryViewModel: ObservableObject {
    @Published var exerciseCategories: [ExerciseCategoryDto] = []
    @Published var errorMessage: ErrorMessage?
    @Published var isLoading: Bool = false

    private let exerciseService = ExerciseService()

    func fetchCategories() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await exerciseService.fetchExerciseCategories()
            exerciseCategories = response
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

}
