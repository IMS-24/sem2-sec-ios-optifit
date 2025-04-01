import SwiftUI

struct WorkoutSetSummaryView: View {
    let set: Components.Schemas.GetWorkoutSetDto
    let maxReps: Int
    let maxWeight: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.primaryAccent)
                        .frame(width: 40, height: 40)
                    Text("\(set.order ?? 0)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            HStack(spacing: 16) {
                HStack {
                    Image(systemName: "repeat")
                        .font(.title2)
                        .foregroundColor(.orange)
                    VStack(alignment: .leading) {
                        Text("Reps")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(set.reps ?? 0)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                Gauge(value: Double(set.reps ?? 0), in: 0...Double(maxReps)) {
                } currentValueLabel: {
                    Text("\(set.reps ?? 0)")
                        .font(.caption2)
                }
                .tint(.orange)
                .frame(width: 80)
            }
            HStack(spacing: 16) {
                HStack {
                    Image(systemName: "dumbbell")
                        .font(.title2)
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Text("Weight")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(set.weight ?? 0.0, specifier: "%.1f") kg")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                Gauge(value: set.weight ?? 0.0, in: 0...maxWeight) {
                } currentValueLabel: {
                    Text("\(set.weight ?? 0.0, specifier: "%.1f")")
                        .font(.caption2)
                }
                .tint(.blue)
                .frame(width: 80)
            }
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding()
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
