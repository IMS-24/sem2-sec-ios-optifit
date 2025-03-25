import Foundation

struct UpdateUserProfileDto: Codable {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var dateOfBirthUtc: Date?
    var initialSetupDone: Bool = false
}
