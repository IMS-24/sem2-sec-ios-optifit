import SwiftUI

struct ExerciseWorkoutSummaryView: View {
    let statistics: Components.Schemas.GetExerciseStatisticsDto

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            OverallExerciseStatsCard(statistics: statistics)
            OverallProgressPerExerciseCharts(workoutExercises: statistics.exerciseWorkoutsDto ?? [])
                .frame(height: 400)  // Adjust height as needed
            ExerciseWorkoutSummary(exerciseWorkoutsDto: statistics.exerciseWorkoutsDto)
                .frame(height: 400)  // Adjust height as needed
        }
    }
}

struct ExerciseWorkoutSummaryViewWrapper: View {

    let viewModel = ExerciseViewModel(exerciseService: MockExerciseService())

    @State private var statistics: Components.Schemas.GetExerciseStatisticsDto?

    var body: some View {
        ExerciseWorkoutSummaryView(statistics: statistics ?? Components.Schemas.GetExerciseStatisticsDto(exerciseWorkoutsDto: nil))
            .environmentObject(viewModel)
            .onAppear {
                Task {
                    let res = await viewModel.loadStatistics(exerciseId: UUID())
                    statistics = res
                }
            }

    }
}

struct ExerciseWorkoutSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseWorkoutSummaryViewWrapper()
    }
}
