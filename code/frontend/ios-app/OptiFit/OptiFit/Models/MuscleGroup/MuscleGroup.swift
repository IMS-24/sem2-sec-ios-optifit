//
//  MuscleGroup[.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct MuscleGroup: Codable, Hashable, Equatable {
    static func == (lhs: MuscleGroup, rhs: MuscleGroup) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    let i18NCode: String
    let muscles: [Muscle]?
}
