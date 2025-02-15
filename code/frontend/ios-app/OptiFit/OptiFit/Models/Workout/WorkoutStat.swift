//
//  WorkoutStat.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct WorkoutStat: Identifiable {
    let id = UUID()
    let day: String
    let workoutMinutes: Int
}
