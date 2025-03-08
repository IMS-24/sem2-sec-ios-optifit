import SwiftUI

struct ExerciseSetDetailView: View {
    let selectedExercise: GetExerciseDto
    let order: Int
    let onSave: (CreateWorkoutExerciseDto) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var createWorkoutExerciseDto: CreateWorkoutExerciseDto
    
    init(selectedExercise: GetExerciseDto, order: Int, onSave: @escaping (CreateWorkoutExerciseDto) -> Void) {
        self.selectedExercise = selectedExercise
        self.order = order
        self.onSave = onSave
        
        _createWorkoutExerciseDto = State(initialValue: CreateWorkoutExerciseDto(
            id: UUID(),
            order: order,
            exercise: selectedExercise,
            notes: "Frontend - <Not implemented yet>",
            workoutSets: []
        ))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Exercise") {
                    Text(selectedExercise.i18NCode)
                }
                
                Section("Sets") {
                    // Reuse the input view which now grows based on content.
                    WorkoutSetsEntryView(
                        sets: createWorkoutExerciseDto.workoutSets,
                        onDeleteSet: { index in
                            createWorkoutExerciseDto.workoutSets.remove(at: index)
                        },
                        onUpdateSet: { index, newReps, newWeight in
                            let repsValue = Int(newReps) ?? 0
                            let weightValue = Double(newWeight) ?? 0.0
                            createWorkoutExerciseDto.workoutSets[index].reps = repsValue
                            createWorkoutExerciseDto.workoutSets[index].weight = weightValue
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
                        let workoutExercise = CreateWorkoutExerciseDto(
                            id: UUID(),
                            order: order,
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
        let newOrder = (createWorkoutExerciseDto.workoutSets.last?.order ?? 0) + 1
        createWorkoutExerciseDto.workoutSets.append(CreateWorkoutSetDto(id:UUID(),order: newOrder, reps: nil, weight: nil))
    }
}

#Preview {
    ExerciseSetDetailView(selectedExercise: GetExerciseDto(id: UUID(), i18NCode: "Exercise Name", description: "Exercise Description", exerciseCategoryId: UUID(), exerciseCategory: "Legs"), order: 1, onSave: { _ in})
}
