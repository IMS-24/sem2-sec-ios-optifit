//
//  Gym.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct GetGymDto: Identifiable, Codable, Equatable, Hashable {
    static func ==(lhs: GetGymDto, rhs: GetGymDto) -> Bool {
        lhs.id == rhs.id
    }

    let address: String
    let zipCode: Int
    let id: UUID
    let name: String
    let city: String
}
