

import Foundation
struct GetWorkoutExerciseDto: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    let order: Int
    let workoutId: UUID
    let exerciseId: UUID
    let workoutSets: [GetWorkoutSetDto]?   // optional in case there are none
    let notes: String?
}

