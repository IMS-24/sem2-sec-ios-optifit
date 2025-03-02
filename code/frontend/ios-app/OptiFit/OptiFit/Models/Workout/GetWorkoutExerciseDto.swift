

import Foundation
struct GetWorkoutExerciseDto: Decodable{
    let order: Int
    let workoutId: UUID
    let exerciseId: UUID
    let workoutSets: [GetWorkoutSetDto]?
    let notes: String?
}

