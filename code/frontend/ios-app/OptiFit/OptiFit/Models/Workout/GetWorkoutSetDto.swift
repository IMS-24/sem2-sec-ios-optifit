import Foundation

struct GetWorkoutSetDto: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    let order: Int
    let reps: Int
    let weight: Double
    let workoutExerciseId: UUID
}
