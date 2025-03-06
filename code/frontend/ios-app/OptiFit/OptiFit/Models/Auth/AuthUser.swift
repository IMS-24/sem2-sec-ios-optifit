//
//  AuthUser.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 06.03.25.
//


import SwiftUI
import MSAL
import  Foundation
/// Represents the authenticated user decoded from the JWT.
struct AuthUser: Codable, Identifiable {
    // Typically the "sub" claim uniquely identifies the user.
    var id: UUID { sub }
    let sub: UUID
    let name: String?
    let email: String?
    let firstLogin: Bool? //TODO: Check naming
    // Add additional fields if your JWT contains more claims.
}
