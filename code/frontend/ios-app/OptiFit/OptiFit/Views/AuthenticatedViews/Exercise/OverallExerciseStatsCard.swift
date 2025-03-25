import SwiftUI

struct OverallExerciseStatsCard: View {
    let statistics: GetExerciseStatisticsDto

    var overallMaxWeight: Double {
        statistics.exerciseWorkoutsDto
            .flatMap { $0.workoutSets }
            .map { $0.weight }
            .max() ?? 0
    }

    var overallMaxReps: Int {
        statistics.exerciseWorkoutsDto
            .flatMap { $0.workoutSets }
            .map { $0.reps }
            .max() ?? 0
    }

    var overallMaxVolume: Double {
        statistics.exerciseWorkoutsDto
            .flatMap { $0.workoutSets }
            .map { Double($0.reps) * $0.weight }
            .max() ?? 0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overall Exercise Statistics")
                .font(.headline)
            HStack {
                VStack(alignment: .leading) {
                    Text("Max Weight")
                        .font(.caption)
                    Text(String(format: "%.2f kg", overallMaxWeight))
                        .bold()
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Max Reps")
                        .font(.caption)
                    Text("\(overallMaxReps)")
                        .bold()
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Max Volume")
                        .font(.caption)
                    Text(String(format: "%.2f", overallMaxVolume))
                        .bold()
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
        .padding(.horizontal)
    }
}
