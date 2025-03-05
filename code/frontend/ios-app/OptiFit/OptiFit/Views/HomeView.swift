//
//  HomeView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var userProfileViewModel = UserProfileViewModel()
    @StateObject private var workoutViewModel = WorkoutViewModel()
    
    // Computed property that aggregates workout summaries by weekday.
    private var aggregatedSummaries: [String: WorkoutSummary] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"  // e.g. "Mon", "Tue", etc.
        var result: [String: WorkoutSummary] = [:]
        
        for workout in workoutViewModel.workouts {
            let dayKey = formatter.string(from: workout.startAtUtc)
            let summary = workout.workoutSummary
            
            if let existing = result[dayKey] {
                result[dayKey] = WorkoutSummary(
                    totalTime: existing.totalTime + summary.totalTime,
                    totalSets: existing.totalSets + summary.totalSets,
                    totalReps: existing.totalReps + summary.totalReps,
                    totalWeight: existing.totalWeight + summary.totalWeight,
                    totalExercises: existing.totalExercises + summary.totalExercises
                )
            } else {
                result[dayKey] = summary
            }
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                
               // StatisticsView(stats: userProfileViewModel.stats)
                
                // Pass the aggregated summaries dictionary to the WorkoutSummaryView.
                WorkoutSummaryView(data: aggregatedSummaries)
                
                Spacer()
                QuickActionsView()
            }
            .navigationTitle("Home")
            .padding()
        }
        .onAppear {
            Task {
                await userProfileViewModel.loadStats()
                await workoutViewModel.searchWorkouts()
            }
        }
        .alert(item: $userProfileViewModel.errorMessage) { error in
            Alert(title: Text("Error"),
                  message: Text(error.message),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HomeView()
}
