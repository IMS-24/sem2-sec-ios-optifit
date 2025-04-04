import SwiftUI

struct WorkoutExerciseListEntryView: View {
    @Binding var workoutExercise: Components.Schemas.CreateWorkoutExerciseDto

    // Total weight computed from each set: weight * reps.
    var totalWeight: Double {
        workoutExercise.workoutSets?.reduce(0) { sum, set in
            let weight = set.weight ?? 0.0
            let reps = set.reps ?? 1
            return sum + weight * Double(reps)
        } ?? 0
    }

    // Total reps computed from each set.
    var totalReps: Int {
        Int(workoutExercise.workoutSets?.reduce(0) { $0 + ($1.reps ?? 0) } ?? 0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header Row: Exercise name and order.
            HStack {
                Text((workoutExercise.exercise?.i18NCode)!)
                    .font(.headline)
                Spacer()
                Text("Order: \(workoutExercise.order!)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Divider()
            // Summary Row: Total Sets, Total Reps, and Total Weight.
            HStack {
                VStack(alignment: .leading) {
                    Text("Total Sets")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(workoutExercise.workoutSets?.count ?? 0)")
                        .font(.body)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Total Reps")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(totalReps)")
                        .font(.body)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Total Weight")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(totalWeight, specifier: "%.2f")")
                        .font(.body)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
