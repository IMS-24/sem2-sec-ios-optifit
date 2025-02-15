//
//  HomeViewModel.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var stats: [Stat] = [
        Stat(title: "Workouts", value: 24),
        Stat(title: "Calories", value: 3250),
        Stat(title: "Active Days", value: 15),
        Stat(title: "Average Workout", value: 65)
    ]

    @Published var workoutData: [WorkoutStat] = [
        WorkoutStat(day: "Mon", workoutMinutes: 65),
        WorkoutStat(day: "Tue", workoutMinutes: 100),
        WorkoutStat(day: "Wed", workoutMinutes: 72),
        WorkoutStat(day: "Thu", workoutMinutes: 60),
        WorkoutStat(day: "Fri", workoutMinutes: 90),
        WorkoutStat(day: "Sat", workoutMinutes: 120),
        WorkoutStat(day: "Sun", workoutMinutes: 45)
    ]
}
