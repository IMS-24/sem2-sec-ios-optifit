import SwiftUI

struct WorkoutExercisesListView: View {
    @Binding var workoutExercises: [Components.Schemas.CreateWorkoutExerciseDto]
    var onDelete: (IndexSet) -> Void = { _ in }
    var onMove: (IndexSet, Int) -> Void = { _, _ in }
    
    var body: some View {
        if workoutExercises.isEmpty {
            Text("No exercises added yet.")
                .foregroundColor(.gray)
                .padding(.vertical)
                .padding(.horizontal)
        } else {
            List {
                ForEach(workoutExercises.indices, id: \.self) { index in
                    NavigationLink(
                        destination: WorkoutExerciseEditView(workoutExercise: $workoutExercises[index])
                    ) {
                        WorkoutExerciseListEntryView(workoutExercise: $workoutExercises[index])
                    }
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}
