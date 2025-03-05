//
//  Gym.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct Gym: Identifiable, Codable,Equatable, Hashable {
    static func == (lhs: Gym, rhs: Gym) -> Bool {
        lhs.id == rhs.id
    }
    let address: String
    let zipCode: Int
    let id: UUID
    let name: String
    let city: String
}
