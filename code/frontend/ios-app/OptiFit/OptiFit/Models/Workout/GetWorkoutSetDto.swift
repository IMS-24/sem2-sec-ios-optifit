

import Foundation

struct GetWorkoutSetDto: Decodable{
    let id: UUID
    let order: Int
    let reps: Int
    let weight: Double
    let workoutExerciseId: UUID
}

