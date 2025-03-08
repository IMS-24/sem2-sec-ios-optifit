

import Foundation

struct GetMuscleGroupDto: Codable, Hashable, Equatable {
    static func ==(lhs: GetMuscleGroupDto, rhs: GetMuscleGroupDto) -> Bool {
        lhs.id == rhs.id
    }

    let id: UUID
    let i18NCode: String
    let muscles: [GetMuscleDto]?
}
