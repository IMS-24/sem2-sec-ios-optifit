
import Foundation
struct UserProfileInitializeDto: Codable,Equatable {
    var firstName: String
    var lastName: String
    var oId: UUID
    var email: String
    var dateOfBirthUtc: Date?
}
