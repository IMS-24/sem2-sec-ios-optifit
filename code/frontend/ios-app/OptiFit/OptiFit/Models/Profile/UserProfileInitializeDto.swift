//
//  UserProfileInitializeDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//
import Foundation
struct UserProfileInitializeDto: Codable,Equatable {
    var firstName: String
    var lastName: String
    var oId: UUID
    var email: String
    var dateOfBirthUtc: Date?
}
/*
 public class InitializeUserProfileDto
 {
 public string FirstName { get; set; } = null!;
 public string LastName { get; set; } = null!;
 public Guid OId { get; set; }
 public string Email { get; set; } = null!;
 public DateTimeOffset DateOfBirthUtc { get; set; }
 }
 */
