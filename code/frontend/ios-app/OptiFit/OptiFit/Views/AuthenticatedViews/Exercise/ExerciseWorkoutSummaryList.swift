
import SwiftUI

struct ExerciseWorkoutSummaryList: View {
    let statistics: GetExerciseStatisticsDto

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            OverallExerciseStatsCard(statistics: statistics)
            OverallProgressPerExerciseCharts(workoutExercises: statistics.exerciseWorkoutsDto)
            ForEach(statistics.exerciseWorkoutsDto) { workoutExercise in
                ExerciseWorkoutSummaryCard(workoutExercise: workoutExercise)
            }
        }
    }
}
