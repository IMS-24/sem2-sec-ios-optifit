import SwiftUI

struct OverallExerciseStatsCard: View {
    let statistics: Components.Schemas.GetExerciseStatisticsDto
    
    // Extract all workout sets from the exercise workouts.
    var allWorkoutSets: [Components.Schemas.GetWorkoutSetDto] {
        (statistics.exerciseWorkoutsDto ?? []).flatMap { $0.workoutSets ?? [] }
    }
    
    var overallMaxWeight: Double {
        allWorkoutSets
            .map { $0.weight ?? 0 }
            .max() ?? 0
    }
    
    var overallMaxReps: Int {
        allWorkoutSets
            .map { Int($0.reps ?? 0) }
            .max() ?? 0
    }
    
    var overallMaxVolume: Double {
        allWorkoutSets
            .map { Double($0.reps ?? 0) * ($0.weight ?? 0) }
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
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
        .padding(.horizontal)
    }
}
