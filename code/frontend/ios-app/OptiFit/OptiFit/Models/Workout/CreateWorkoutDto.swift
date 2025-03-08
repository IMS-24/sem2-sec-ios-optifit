
import Foundation

struct CreateWorkoutDto: Codable {
    let description: String
    let startAtUtc: Date
    let endAtUtc: Date
    let notes: String
    let gymId: UUID
    let workoutExercises: [CreateWorkoutExerciseDto]
}
