import Foundation

struct ExerciseWorkoutDto: Codable, Identifiable, Hashable, Equatable {
    var id: UUID

    static func == (lhs: ExerciseWorkoutDto, rhs: ExerciseWorkoutDto) -> Bool {
        lhs.exerciseId == rhs.exerciseId && lhs.workout.id == rhs.workout.id
    }

    let order: Int
    let workout: GetWorkoutDto
    let exerciseId: UUID
    let workoutSets: [GetWorkoutSetDto]
    let notes: String
}
