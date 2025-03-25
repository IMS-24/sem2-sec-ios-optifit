import Foundation

struct GetWorkoutExerciseDto: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    let order: Int
    let workoutId: UUID
    let exercise: GetExerciseDto
    let workoutSets: [GetWorkoutSetDto]?
    let notes: String?
}
