import Foundation

struct UserProfileDto: Codable, Equatable {

    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var userRole: String?
    var dateOfBirthUtc: Date?
    var lastLoginUtc: Date?
    var registeredUtc: Date?
    var updatedUtc: Date?
    var initialSetupDone: Bool
}
