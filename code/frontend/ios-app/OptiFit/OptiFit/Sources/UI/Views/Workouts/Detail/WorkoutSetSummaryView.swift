import SwiftUI
struct WorkoutSetSummaryView: View {
    let set: Components.Schemas.GetWorkoutSetDto
    let maxReps: Int
    let maxWeight: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with set number
            HStack {
                Text("Set \(set.order ?? 0)")
                    .font(.headline)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(8)
                Spacer()
            }
            
            // Two columns: Reps and Weight
            HStack(spacing: 16) {
                // Reps Column
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "repeat")
                            .foregroundColor(.orange)
                        Text("Reps")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(set.reps ?? 0)")
                            .font(.subheadline)
                            .bold()
                    }
                    ProgressView(value: Double(set.reps ?? 0), total: Double(maxReps))
                        .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                }
                .frame(maxWidth: .infinity)
                
                // Weight Column
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "dumbbell")
                            .foregroundColor(.blue)
                        Text("Weight")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(set.weight ?? 0.0, specifier: "%.1f") kg")
                            .font(.subheadline)
                            .bold()
                    }
                    ProgressView(value: set.weight ?? 0.0, total: maxWeight)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .padding([.horizontal, .top])
    }
}


#Preview {
    WorkoutSetSummaryView(
        set: .init(
            id: UUID().uuidString,
            order: 1,
            reps: 10,
            weight: 20.0,
            workoutExerciseId: UUID().uuidString
        ),
        maxReps: 10,
        maxWeight: 20.5
    )
}
