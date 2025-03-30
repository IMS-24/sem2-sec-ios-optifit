import SwiftUI

struct ExerciseSetDetailView: View {
    let selectedExercise: Components.Schemas.GetExerciseDto
    let order: Int
    let onSave: (Components.Schemas.CreateWorkoutExerciseDto) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var createWorkoutExerciseDto: Components.Schemas.CreateWorkoutExerciseDto

    init(selectedExercise: Components.Schemas.GetExerciseDto, order: Int, onSave: @escaping (Components.Schemas.CreateWorkoutExerciseDto) -> Void) {
        self.selectedExercise = selectedExercise
        self.order = order
        self.onSave = onSave

        _createWorkoutExerciseDto = State(
            initialValue: Components.Schemas.CreateWorkoutExerciseDto(
                id: UUID().uuidString,
                order: Int32(order),
                exercise: selectedExercise,
                notes: "Frontend - <Not implemented yet>",
                workoutSets: []
            ))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Exercise") {
                    Text(selectedExercise.i18NCode!)
                }
                Section("Sets") {
                    // Reuse the input view which now grows based on content.
                    WorkoutSetsEntryView(
                        sets: createWorkoutExerciseDto.workoutSets ?? [],
                        onDeleteSet: { index in
                            // Ensure that workoutSets is not nil before removing
                            if createWorkoutExerciseDto.workoutSets != nil {
                                createWorkoutExerciseDto.workoutSets!.remove(at: index)
                            }
                        },
                        onUpdateSet: { index, newReps, newWeight in
                            if createWorkoutExerciseDto.workoutSets != nil {
                                let repsValue = Int(newReps) ?? 0
                                let weightValue = Double(newWeight) ?? 0.0
                                createWorkoutExerciseDto.workoutSets![index].reps = Int32(repsValue)
                                createWorkoutExerciseDto.workoutSets![index].weight = weightValue
                            }
                        }
                    )

                    // "Add Set" button placed outside the reusable view.
                    Button(action: addSet) {
                        Label("Add Set", systemImage: "plus.circle.fill")
                    }
                }

                Section("Notes") {
                    Text("Coming Soon")
                }
            }
            .navigationTitle("Add Set Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let workoutExercise = Components.Schemas.CreateWorkoutExerciseDto(
                            id: UUID().uuidString,
                            order: Int32(order),
                            exercise: selectedExercise,
                            notes: createWorkoutExerciseDto.notes,
                            workoutSets: createWorkoutExerciseDto.workoutSets
                        )
                        onSave(workoutExercise)
                    }
                }
            }
        }
    }

    private func addSet() {
        let newOrder = (createWorkoutExerciseDto.workoutSets?.last?.order ?? 0) + 1
        let set = Components.Schemas.CreateWorkoutSetDto(
            id: UUID().uuidString,
            order: newOrder,
            reps: nil,
            weight: nil
        )
        // Force unwrap here (safe if you know it’s not nil)
        createWorkoutExerciseDto.workoutSets!.append(set)
    }

}

#Preview {
    let legs = Components.Schemas.GetExerciseCategoryDto()
    ExerciseSetDetailView(
        selectedExercise: Components.Schemas.GetExerciseDto(
            id: UUID().uuidString,
            i18NCode: "Exercise Name",
            description: "Exercise Description",
            exerciseCategory: legs,
            exerciseCategoryId: legs.id
        ),
        order: 1,
        onSave: { _ in
        })
}
