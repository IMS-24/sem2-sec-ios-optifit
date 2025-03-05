//
//  PerformedExercise.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 22.02.25.
//

import Foundation

struct PerformedExercise: Identifiable {
    let id = UUID()
    let name: String
//    let sets: [WorkoutSet]
    let sets: [CreateWorkoutSetDto]
}
