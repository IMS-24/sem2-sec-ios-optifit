import SwiftUI

struct WorkoutSetSummaryView: View {
    let set: Components.Schemas.GetWorkoutSetDto
    // Assumed maximum values to normalize the gauge.
    let maxReps: Int = 20
    let maxWeight: Double = 100.0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack{
                Text("\(set.order!)")
                    .font(.headline)
                    .foregroundColor(Color(.primaryAccent))
                Spacer()
                Text("Reps: \(set.reps!)")
                Spacer()
                Text("Weight: \(set.weight!, specifier: "%.1f") kg")
            }
        }
            .padding()
            .background(Color(.secondaryBackground))
            .cornerRadius(12)
       
    }
}
#Preview {
    WorkoutSetSummaryView(set: .init(id: UUID().uuidString, order: 1, reps: 10, weight: 20.0, workoutExerciseId: UUID().uuidString))
}
