import SwiftUI

struct WorkoutSetSummaryView: View {
    let set: Components.Schemas.GetWorkoutSetDto
    // Assumed maximum values to normalize the gauge.
    let maxReps: Int = 20
    let maxWeight: Double = 100.0

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Set \(set.order)")
                    .font(.headline)
                    .foregroundColor(Color(.primaryText))
                Spacer()
            }
            HStack(spacing: 16) {
                VStack {
                    Text("Reps: \(set.reps)")

                }
                VStack {
                    Text("Weight: \(set.weight!, specifier: "%.1f")")
                }
            }
        }
        .padding()
        .background(Color(.secondaryBackground))
        .cornerRadius(10)
    }
}
#Preview {
    WorkoutSetSummaryView(set: .init(id: UUID().uuidString, order: 1, reps: 10, weight: 20.0, workoutExerciseId: UUID().uuidString))
}
