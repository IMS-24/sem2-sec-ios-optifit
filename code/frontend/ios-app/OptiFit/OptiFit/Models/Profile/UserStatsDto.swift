struct UserStatsDto: Codable {
    let activeDays: Int
    let totalWorkouts: Int
    let totalExercises: Int
    let totalSets: Int
    let totalReps: Int
    let totalWeight: Int
    let totalDuration: Int
    let totalCalories: Int
    let workoutStreak: Int
    let averageDuration: Int
}
