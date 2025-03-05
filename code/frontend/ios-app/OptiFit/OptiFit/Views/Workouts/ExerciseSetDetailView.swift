import SwiftUI

struct ExerciseSetDetailView: View {
    let selectedExercise: GetExerciseDto
    @State private var createWorkoutExerciseDto: CreateWorkoutExerciseDto
    //@State private var sets: [WorkoutSet] = [WorkoutSet(order: 1, reps: nil, weight: nil)]
//    @State private var notes: String = ""
    init(selectedExercise: GetExerciseDto, onSave: @escaping (CreateWorkoutExerciseDto) -> Void) {
        self.selectedExercise = selectedExercise
        _createWorkoutExerciseDto = State(initialValue: CreateWorkoutExerciseDto(
            order: 1,
            exerciseId: selectedExercise.id,
            notes: nil,
            workoutSets: []
        ))
        self.onSave = onSave
    }
    
    let onSave: (CreateWorkoutExerciseDto) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Exercise [CHECK]")) {
                    Text(selectedExercise.i18NCode)
                }
                Section(header: Text("Enter Sets")) {
                    WorkoutSetsEntryView(sets:$createWorkoutExerciseDto.workoutSets)
                        .frame(maxHeight: .infinity)
                }
//                Section(header: Text("Notes")){
//                        TextEditor(text: $notes)
//                            .frame(minHeight: 100)
//                            .overlay(RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.gray, lineWidth: 1))
//                            .padding(.top, 4)
//                    
//                }
            }
            .navigationTitle("Add Set Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let workoutExercise = CreateWorkoutExerciseDto(order: 1, exerciseId: selectedExercise.id, workoutSets: createWorkoutExerciseDto.workoutSets)
//                        let performedExercise = PerformedExercise(name: selectedExercise.i18NCode, sets: createWorkoutExerciseDto.workoutSets)
                        onSave(workoutExercise)
                    }
                }
            }
        }
    }
}
