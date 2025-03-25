import Foundation

struct UpdateExerciseDto: Codable {
    let i18NCode: String?
    let description: String?
    let exerciseCategoryId: UUID
}
