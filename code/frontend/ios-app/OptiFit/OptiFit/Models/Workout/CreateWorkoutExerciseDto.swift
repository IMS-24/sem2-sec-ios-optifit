import Foundation

struct CreateWorkoutExerciseDto: Codable, Identifiable {
    var id: UUID
    var order: Int
    var exercise: GetExerciseDto
    var notes: String?
    var workoutSets: [CreateWorkoutSetDto]
}
