import SwiftUI

struct ExerciseSetDetailView: View {
    let selectedExercise: GetExerciseDto
    @State private var sets: [WorkoutSet] = [WorkoutSet(order: 1, reps: nil, weight: nil)]
    let onSave: (PerformedExercise) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Exercise")) {
                    Text(selectedExercise.i18NCode)
                }
                Section(header: Text("Enter Sets")) {
                    WorkoutSetsEntryView(sets: $sets)
                        .frame(maxHeight: .infinity)
                }
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
                        let performedExercise = PerformedExercise(name: selectedExercise.i18NCode, sets: sets)
                        onSave(performedExercise)
                    }
                }
            }
        }
    }
}
