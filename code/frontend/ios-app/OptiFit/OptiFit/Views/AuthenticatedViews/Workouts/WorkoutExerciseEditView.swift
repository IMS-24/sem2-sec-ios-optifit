import SwiftUI

struct WorkoutExerciseEditView: View {
    @Binding var workoutExercise: Components.Schemas.CreateWorkoutExerciseDto

    var body: some View {
        Form {
            Section(header: Text("Exercise")) {
                Text(workoutExercise.exercise!.i18NCode!)
            }
            Section(header: Text("Order")) {
                Text("\(workoutExercise.order!)")
            }
            Section(header: Text("Sets")) {
                if ((workoutExercise.workoutSets?.isEmpty) != nil) {
                    Text("No sets added.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(workoutExercise.workoutSets!.indices, id: \.self) { index in
                        HStack {
                            Text("Set \(index + 1)")
                            Spacer()
                            let reps = workoutExercise.workoutSets?[index].reps ?? 0
                            let weight = workoutExercise.workoutSets?[index].weight ?? 0.0
                            Text("Reps: \(reps), Weight: \(weight, specifier: "%.2f")")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            // You can add additional sections for editing notes, adding sets, etc.
        }
        .navigationTitle("Edit Exercise")
    }
}
