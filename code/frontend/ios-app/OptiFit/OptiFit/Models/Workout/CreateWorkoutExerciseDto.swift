//
//  CreateWorkoutExerciseDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 05.03.25.
//

import Foundation

struct CreateWorkoutExerciseDto: Codable, Identifiable {
    var id: UUID?
    var order: Int
    var exerciseId: UUID
    var notes: String?
    var workoutSets: [CreateWorkoutSetDto]
}
