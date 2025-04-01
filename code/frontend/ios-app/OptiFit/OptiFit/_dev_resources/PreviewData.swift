//
//  PreviewData.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 01.04.25.
//
import Foundation
struct PreviewData {
    var user_1: Components.Schemas.UserProfileDto = .init(
        id: "id_1",
        userName: "user_1",
        email: "user_1@example.com",
        firstName: "Pepe",
        lastName: "Pong",
        dateOfBirthUtc: Date(),
        lastLoginUtc: Date(),
        registeredUtc: Date(),
        updatedUtc: Date(),
        initialSetupDone: true
    )
    
    
}
