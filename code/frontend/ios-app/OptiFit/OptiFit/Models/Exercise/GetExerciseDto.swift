
import Foundation

struct GetExerciseDto: Codable,Identifiable, Hashable, Equatable {
    static func == (lhs: GetExerciseDto, rhs: GetExerciseDto) -> Bool {
        lhs.id == rhs.id
    }
    let id: UUID
    let i18NCode: String
    let description: String?
    let exerciseCategoryId: UUID
    let exerciseCategory: String
    let imageURL: URL?
}
