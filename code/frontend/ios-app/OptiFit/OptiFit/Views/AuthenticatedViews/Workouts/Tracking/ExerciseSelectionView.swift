//Done: 2025-03-05: 15:07

import SwiftUI

struct ExerciseSelectionView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    let exerciseCategoryId: UUID
    let onExerciseSelected: (CreateWorkoutExerciseDto) -> Void
    let order: Int
    var body: some View {
        List(exerciseViewModel.exercises) { exercise in
            NavigationLink(
                destination: LazyView {
                    ExerciseSetDetailView(selectedExercise: exercise, order:order, onSave: onExerciseSelected)
                }
            ) {
                Text(exercise.i18NCode)
            }
        }
        .navigationTitle("Select Exercise")
                .onAppear {
                    let updatedSearchModel = SearchExercisesDto(exerciseCategoryId: exerciseCategoryId)
                    exerciseViewModel.updateSearchModel(updatedSearchModel)
                }
    }
}

#Preview {
    ExerciseSelectionView(exerciseCategoryId: UUID(),onExerciseSelected: { _ in }, order:1)
}
