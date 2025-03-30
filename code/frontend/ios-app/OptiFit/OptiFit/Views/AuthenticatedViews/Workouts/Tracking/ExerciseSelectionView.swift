import SwiftUI

struct ExerciseSelectionView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    let exerciseCategoryId: UUID
    let onExerciseSelected: (Components.Schemas.CreateWorkoutExerciseDto) -> Void
    let order: Int
    var body: some View {
        List {
            ForEach(exerciseViewModel.exercises, id: \.self) { exercise in
                NavigationLink(
                    destination: LazyView {
                        ExerciseSetDetailView(selectedExercise: exercise, order: order, onSave: onExerciseSelected)
                    }
                ) {
                    Text(exercise.i18NCode!)
                }
            }
        }
        .navigationTitle("Select Exercise")
        .onAppear {
            let updatedSearchModel = Components.Schemas.SearchExerciseDto(exerciseCategoryId: exerciseCategoryId.uuidString)
            exerciseViewModel.updateSearchModel(updatedSearchModel)
        }
    }
}

#Preview {
    ExerciseSelectionView(exerciseCategoryId: UUID(), onExerciseSelected: { _ in }, order: 1)
}
