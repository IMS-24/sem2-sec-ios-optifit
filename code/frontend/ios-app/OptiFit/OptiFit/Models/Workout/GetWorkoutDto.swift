

import Foundation

struct GetWorkoutDto: Codable, Identifiable, Hashable, Equatable {
    static func == (lhs: GetWorkoutDto, rhs: GetWorkoutDto) -> Bool {
        lhs.id == rhs.id
    }
    let id: UUID
    let description: String
    let startAtUtc: Date
    let endAtUtc: Date?
    let notes: String?
    let gymId: UUID
}
