//
//  ExerciseGroup.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct ExerciseCategory: Identifiable, Codable, Equatable {
    let id: UUID
    let i18NCode: String
    let exercises: [GetExerciseDto]?

    static func ==(lhs: ExerciseCategory, rhs: ExerciseCategory) -> Bool {
        return lhs.id == rhs.id
    }
}
