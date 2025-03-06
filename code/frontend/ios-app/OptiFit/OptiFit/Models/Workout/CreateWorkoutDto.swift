//
//  CreateWorkoutDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 02.03.25.
//

import Foundation

struct CreateWorkoutDto: Codable {
    let description: String
    let startAtUtc: Date
    let endAtUtc: Date
    let notes: String
    let gymId: UUID
    let workoutExercises: [CreateWorkoutExerciseDto]
}
