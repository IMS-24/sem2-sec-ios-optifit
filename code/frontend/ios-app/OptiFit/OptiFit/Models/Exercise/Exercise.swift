import Foundation

struct Exercise: Identifiable, Codable, Hashable, Equatable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    let i18NCode: String
    let description: String?
    let muscleGroups: [MuscleGroup]
    let muscles: [Muscle]
    let exerciseType: String
    let imageURL: URL?
}
