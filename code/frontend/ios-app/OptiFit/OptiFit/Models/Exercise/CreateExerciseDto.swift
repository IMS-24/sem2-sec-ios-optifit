import Foundation

struct CreateExerciseDto: Codable {
    let i18NCode: String
    let description: String
    let muscleIds: [UUID]?
    let exerciseCategoryId: UUID
    let imageData: Data?
}
