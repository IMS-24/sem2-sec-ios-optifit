//
//  UserProfileUpdateDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 06.03.25.
//

/*
 UpdateUserProfileDto
 
 public class UpdateUserProfileDto
 {
 public string? FirstName { get; set; }
 public string? LastName { get; set; }
 public string? Email { get; set; }
 public DateTimeOffset? DateOfBirthUtc { get; set; }
 public bool InitialSetupDone { get; set; }
 }

 */
import Foundation
struct UpdateUserProfileDto: Codable {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var dateOfBirthUtc: Date?
    var initialSetupDone: Bool = false
}
