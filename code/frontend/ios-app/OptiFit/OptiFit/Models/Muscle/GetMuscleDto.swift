import Foundation

struct GetMuscleDto: Codable, Hashable, Equatable, Identifiable {
    let id: UUID
    let i18NCode: String
}
