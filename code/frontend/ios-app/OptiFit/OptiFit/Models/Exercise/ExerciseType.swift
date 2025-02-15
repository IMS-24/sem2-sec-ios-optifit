//
//  ExerciseGroup.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct ExerciseType: Identifiable, Codable, Equatable {
    let id: UUID
    let i18NCode: String
    let exercises: [Exercise]?

    static func ==(lhs: ExerciseType, rhs: ExerciseType) -> Bool {
        return lhs.id == rhs.id
    }
}
