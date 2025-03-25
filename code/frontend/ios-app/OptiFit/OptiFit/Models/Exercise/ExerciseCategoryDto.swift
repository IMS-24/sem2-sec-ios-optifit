import Foundation

struct ExerciseCategoryDto: Identifiable, Hashable, Codable, Equatable {
    let id: UUID
    let i18NCode: String
    let exerciseIds: [UUID]?

    static func == (lhs: ExerciseCategoryDto, rhs: ExerciseCategoryDto) -> Bool {
        return lhs.id == rhs.id
    }
}
