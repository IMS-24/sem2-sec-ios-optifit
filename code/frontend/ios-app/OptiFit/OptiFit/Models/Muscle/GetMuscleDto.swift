//
//  Muscle.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct GetMuscleDto: Codable, Hashable, Equatable, Identifiable {
    let id: UUID
    let i18NCode: String
}
