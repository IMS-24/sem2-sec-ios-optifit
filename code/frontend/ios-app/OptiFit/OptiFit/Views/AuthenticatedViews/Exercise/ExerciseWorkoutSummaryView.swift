import SwiftUI

struct ExerciseWorkoutSummaryView: View {
    let statistics: Components.Schemas.GetExerciseStatisticsDto

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            OverallExerciseStatsCard(statistics: statistics)
            OverallProgressPerExerciseCharts(workoutExercises: statistics.exerciseWorkoutsDto ?? [])
                .frame(height: 400) // Adjust height as needed
            ExerciseWorkoutSummary(exerciseWorkoutsDto: statistics.exerciseWorkoutsDto)
                .frame(height: 400) // Adjust height as needed
        }
    }
}
