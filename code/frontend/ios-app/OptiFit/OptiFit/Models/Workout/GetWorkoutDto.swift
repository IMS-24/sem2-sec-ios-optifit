

import Foundation
struct GetWorkoutDto: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    let description: String
    let startAtUtc: Date
    let endAtUtc: Date?         // optional in case it's sometimes missing
    let notes: String?
    let gymId: UUID
    let gym: GetGymDto
    let workoutExercises: [GetWorkoutExerciseDto]?
    let workoutSummary: WorkoutSummary
}

