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
    let emails: [String]?
    var firstLogin: Bool = false // TODO: Change to default false
    let family_name: String?
    let given_name: String?
    
    enum CodingKeys: String, CodingKey {
        case sub, name, emails, firstLogin, family_name, given_name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode sub from string and convert to UUID.
        let subString = try container.decode(String.self, forKey: .sub)
        guard let subUUID = UUID(uuidString: subString) else {
            throw DecodingError.dataCorruptedError(forKey: .sub,
                                                   in: container,
                                                   debugDescription: "Invalid UUID string for sub")
        }
        self.sub = subUUID
        
        self.name = try? container.decode(String.self, forKey: .name)
        
        // Try to decode "emails" as an array of strings.
        if let emailArray = try? container.decode([String].self, forKey: .emails) {
            self.emails = emailArray
        } else if let emailSingle = try? container.decode(String.self, forKey: .emails) {
            // Fallback: if "emails" is a single string instead of an array.
            self.emails = [emailSingle]
        } else {
            self.emails = nil
        }
        
        self.firstLogin = (try? container.decode(Bool.self, forKey: .firstLogin)) ?? false
        
        self.family_name = try? container.decode(String.self, forKey: .family_name)
        self.given_name = try? container.decode(String.self, forKey: .given_name)
    }
    
    // You can also provide a default initializer if needed.
}
