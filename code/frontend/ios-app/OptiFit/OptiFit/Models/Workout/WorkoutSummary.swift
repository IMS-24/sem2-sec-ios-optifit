//
//  WorkoutSummary.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 05.03.25.
//

import Foundation

struct WorkoutSummary: Codable, Equatable, Hashable {
    let totalTime: Double
    let totalSets: Int
    let totalReps: Int
    let totalWeight: Decimal
    let totalExercises: Int
}
