import Foundation

struct GetExerciseStatisticsDto: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let exerciseDto: GetExerciseDto
    let exerciseWorkoutsDto: [ExerciseWorkoutDto]
}
