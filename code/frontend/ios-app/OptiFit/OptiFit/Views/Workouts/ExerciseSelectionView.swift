import SwiftUI

struct ExerciseSelectionView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    let exerciseCategoryId: UUID
    let onExerciseSelected: (CreateWorkoutExerciseDto) -> Void
    
    var body: some View {
        List(exerciseViewModel.exercises) { exercise in
            NavigationLink(destination: ExerciseSetDetailView(selectedExercise: exercise, onSave: onExerciseSelected)) {
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
    // Provide a dummy UUID for preview purposes.
    ExerciseSelectionView(exerciseCategoryId: UUID(), onExerciseSelected: { _ in })
}
