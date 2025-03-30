import SwiftUI

struct WorkoutSetsEntryView: View {
    let sets: [Components.Schemas.CreateWorkoutSetDto]
    let onDeleteSet: (Int) -> Void
    let onUpdateSet: (Int, String, String) -> Void

    var body: some View {
        if sets.isEmpty {
            Text("No sets added yet.")
                .foregroundColor(.gray)
        } else {
            VStack(spacing: 12) {
                ForEach(Array(sets.enumerated()), id: \.element.id) { (index, set) in
                    HStack(spacing: 12) {
                        Text("Set \(index + 1):")
                            .frame(width: 60, alignment: .leading)

                        // Reps field as a string to show placeholder when empty
                        TextField(
                            "Reps",
                            text: Binding(
                                get: {
                                    let reps = set.reps ?? 0
                                    return reps == 0 ? "" : String(reps)
                                },
                                set: { newValue in
                                    onUpdateSet(index, newValue, weightString(for: set))
                                }
                            )
                        )
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 60)

                        // Weight field as a string to show placeholder when empty
                        TextField(
                            "Weight",
                            text: Binding(
                                get: {
                                    let weight = set.weight ?? 0.0
                                    return weight == 0.0 ? "" : String(weight)
                                },
                                set: { newValue in
                                    onUpdateSet(index, repsString(for: set), newValue)
                                }
                            )
                        )
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)

                        Spacer()

                        // Delete button for this set.
                        Button(action: {
                            onDeleteSet(index)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .padding(8)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                }
            }
        }
    }

    // Helper: Convert reps to string for display.
    private func repsString(for set:  Components.Schemas.CreateWorkoutSetDto) -> String {
        let reps = set.reps ?? 0
        return reps == 0 ? "" : String(reps)
    }

    // Helper: Convert weight to string for display.
    private func weightString(for set:  Components.Schemas.CreateWorkoutSetDto) -> String {
        let weight = set.weight ?? 0.0
        return weight == 0.0 ? "" : String(weight)
    }
}

#Preview {
    WorkoutSetsEntryView(
        sets: [
            Components.Schemas.CreateWorkoutSetDto(id: UUID().uuidString, order: 1, reps: 10, weight: 20),
            Components.Schemas.CreateWorkoutSetDto(id: UUID().uuidString, order: 2, reps: 20, weight: 40),
            Components.Schemas.CreateWorkoutSetDto(id: UUID().uuidString, order: 3, reps: 30, weight: 60),
        ], onDeleteSet: { _ in }, onUpdateSet: { _, _, _ in })
}
