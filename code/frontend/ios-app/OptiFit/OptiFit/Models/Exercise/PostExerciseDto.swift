import Foundation

struct PostExerciseDto: Codable {
    let i18NCode: String
    let description: String
    let muscleGroupIds: [UUID]
    let muscleIds: [UUID]?
    let exerciseTypeId: UUID
    let imageData: Data?
}
