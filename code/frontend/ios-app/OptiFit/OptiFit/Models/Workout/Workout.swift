//
//  Workout.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct Workout: Identifiable {
    let id = UUID()
    let date: Date
    let exercises: [ExerciseStat]

    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    var totalSets: Int {
        exercises.reduce(0) {
            $0 + $1.sets
        }
    }

    var totalReps: Int {
        exercises.reduce(0) {
            $0 + ($1.sets * $1.reps)
        }
    }

    var totalWeight: Double {
        exercises.reduce(0) {
            $0 + (Double($1.sets * $1.reps) * $1.weight)
        }
    }
}
