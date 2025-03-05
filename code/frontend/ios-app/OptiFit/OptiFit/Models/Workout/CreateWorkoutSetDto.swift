//
//  CreateWorkoutSetDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 05.03.25.
//

import Foundation

struct CreateWorkoutSetDto: Codable, Identifiable {
    var id: UUID?
    var order: Int?
    var reps: Int?
    var weight: Double?
}
