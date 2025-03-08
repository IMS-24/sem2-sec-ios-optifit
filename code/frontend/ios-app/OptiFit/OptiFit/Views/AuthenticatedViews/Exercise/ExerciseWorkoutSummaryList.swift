//
//  ExerciseWorkoutSummaryList.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 08.03.25.
//

import SwiftUI

struct ExerciseWorkoutSummaryList: View {
    let statistics: GetExerciseStatisticsDto

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            OverallExerciseStatsCard(statistics: statistics)
            OverallProgressPerExerciseCharts(workoutExercises: statistics.exerciseWorkoutsDto)
//            OverallProgressLineChart(workoutExercises: statistics.exerciseWorkoutsDto)
            ForEach(statistics.exerciseWorkoutsDto) { workoutExercise in
                ExerciseWorkoutSummaryCard(workoutExercise: workoutExercise)
            }
        }
    }
}
