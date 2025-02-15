//
//  StatisticsView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct StatisticsView: View {
    @State var stats: UserStatsDto? = nil
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            if let stats = self.stats {
                StatCardView(stat: Stat(title: "Active Days", value:stats.activeDays))
                StatCardView(stat: Stat(title: "Average Duration", value:stats.averageDuration))
                StatCardView(stat: Stat(title: "Total Calories", value:stats.totalCalories))
                StatCardView(stat: Stat(title: "Total Duration", value:stats.totalDuration))
                StatCardView(stat: Stat(title: "Total Exercises", value:stats.totalExercises))
                StatCardView(stat: Stat(title: "Total Reps", value:stats.totalReps))
                
                StatCardView(stat: Stat(title: "Total Sets", value:stats.totalSets))
                StatCardView(stat: Stat(title: "Total Weight", value:stats.totalWeight))
                StatCardView(stat: Stat(title: "Total Workouts", value:stats.totalWorkouts))
                StatCardView(stat: Stat(title: "Workout Streak", value:stats.workoutStreak))
                
                
                
            }
        }
                .padding()
    }
}

#Preview {
    StatisticsView(stats: UserStatsDto(
        activeDays: 1, totalWorkouts: 2, totalExercises: 3, totalSets: 4, totalReps: 5, totalWeight: 6, totalDuration: 7, totalCalories: 8, workoutStreak: 9, averageDuration: 10
    ))
}
