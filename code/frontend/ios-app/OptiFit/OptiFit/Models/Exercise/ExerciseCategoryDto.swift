//
//  ExerciseGroup.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct ExerciseCategoryDto: Identifiable, Codable, Equatable {
    let id: UUID
    let i18NCode: String
    let exerciseIds: [UUID]?

    static func ==(lhs: ExerciseCategoryDto, rhs: ExerciseCategoryDto) -> Bool {
        return lhs.id == rhs.id
    }
}
