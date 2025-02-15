//
//  UserProfile.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

struct UserProfile: Codable {
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var userRole: String
    var dateOfBirthUtc: Date?
    var lastLoginUtc: Date?
    var registeredUtc: Date
    var updatedUtc: Date
    var initialSetupDone: Bool
}

