import SwiftUI

struct WorkoutExerciseEditView: View {
    @Binding var workoutExercise: Components.Schemas.CreateWorkoutExerciseDto

    var body: some View {
        Form {
            Section(header: Text("Exercise")) {
                Text(workoutExercise.exercise!.i18NCode!)
            }
            Section(header: Text("Order")) {
                Text("\(workoutExercise.order)")
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
//
//struct WorkoutExerciseEditView_PreviewWrapper: View {
//    @State var legs = State(initialValue: .init(id: UUID(), i18NCode: "Legs", exerciseIds: []))
//
//    @State var workoutExercise: CreateWorkoutExerciseDto = State(initialValue:.init(
//        id: UUID(),
//        order: 1,
//        exercise: GetExerciseDto(
//            id: UUID(),
//            i18NCode: "Exercise Name",
//            description: "Exercise Description",
//            exerciseCategoryId: legs.id,
//            exerciseCategory: legs
//        ),
//        workoutSets: [
//            CreateWorkoutSetDto(id: UUID(), order: 1, reps: 10, weight: 10.1),
//            CreateWorkoutSetDto(id: UUID(), order: 2, reps: 20, weight: 20),
//            CreateWorkoutSetDto(id: UUID(), order: 3, reps: 30, weight: 30)
//        ]
//    )
//    )
//
//    var body: some View {
//        NavigationStack {
//            WorkoutExerciseEditView(workoutExercise: $workoutExercise)
//        }
//    }
//}
//
//#Preview {
//    WorkoutExerciseEditView_PreviewWrapper()
//}
