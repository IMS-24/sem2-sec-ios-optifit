import SwiftUI

struct ExerciseSetDetailView: View {
    let selectedExercise: GetExerciseDto
    @State private var weight: Double = 0.0
    @State private var reps: Int = 0

    /// Called when the user saves the set details.
    let onSave: (PerformedExercise) -> Void

    var body: some View {
        Form {
            Section(header: Text("Exercise")) {
                Text(selectedExercise.i18NCode)
            }
            Section(header: Text("Set Information")) {
                TextField("Weight", value: $weight, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Reps", value: $reps, format: .number)
                    .keyboardType(.numberPad)
            }
            Button("Save") {
                let performedExercise = PerformedExercise(name: selectedExercise.i18NCode, weight: weight, reps: reps)
                onSave(performedExercise)
            }
        }
        .navigationTitle("Add Set Info")
    }
}

#Preview {
    // Dummy preview using sample exercise details.
    ExerciseSetDetailView(
        selectedExercise: GetExerciseDto(
            id: UUID(),
            i18NCode: "Bench Press",
            description: "Chest exercise",
            exerciseCategoryId: UUID(),
            exerciseCategory: "Strength"
        ),
        onSave: { _ in }
    )
}
