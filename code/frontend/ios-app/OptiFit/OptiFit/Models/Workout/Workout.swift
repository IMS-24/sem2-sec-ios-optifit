//
//  Workout.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct Workout: Identifiable {
    let id: UUID
    let date: Date
    let exercises: [ExerciseStat]


}

