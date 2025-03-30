
import SwiftUI

/// A separate row view to handle local text state for a single workout set.
struct WorkoutSetRowView: View {
    let set: Components.Schemas.CreateWorkoutSetDto
    let index: Int
    let onDelete: (Int) -> Void
    let onUpdate: (Int, String, String) -> Void

    @State private var repsText: String = ""
    @State private var weightText: String = ""

    var body: some View {
        HStack(spacing: 12) {
            Text("Set \(index + 1):")
                .frame(width: 60, alignment: .leading)

            // Reps input field.
            CustomTextField(
                text: $repsText,
                placeholder: "Reps",
                keyboardType: .numberPad,
                onEditingEnded: {
                    print("Reps lost focus: \(repsText)")
                    onUpdate(index, repsText, weightText)
                }
            )
            .frame(width: 60)

            // Weight input field.
            CustomTextField(
                text: $weightText,
                placeholder: "Weight",
                keyboardType: .decimalPad,
                onEditingEnded: {
                    print("Weight lost focus: \(weightText)")
                    onUpdate(index, repsText, weightText)
                }
            )
            .frame(width: 80)

            Spacer()

            // Delete button.
            Button {
                onDelete(index)
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(8)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
        .onAppear {
            // Initialize local text states from the model.
            repsText = repsString(for: set)
            weightText = weightString(for: set)
        }
    }

    // Helper: Convert reps to string for display.
    private func repsString(for set: Components.Schemas.CreateWorkoutSetDto) -> String {
        let reps = set.reps ?? 0
        return reps == 0 ? "" : String(reps)
    }

    // Helper: Convert weight to string for display.
    private func weightString(for set: Components.Schemas.CreateWorkoutSetDto) -> String {
        let weight = set.weight ?? 0.0
        return weight == 0.0 ? "" : String(weight)
    }
}

#Preview {
    WorkoutSetRowView(
        set: .init(id:"11", order: 1, reps: 10, weight: 55.5),
        index: 0,
        onDelete:
            {index in
        print("delete Index")
    },
        onUpdate: { index, reps, weight in
        print("[index: \(index)] reps: \(reps), weight: \(weight)")
    })
}
