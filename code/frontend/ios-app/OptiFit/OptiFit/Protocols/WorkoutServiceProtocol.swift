
protocol WorkoutServiceProtocol: Sendable {
    func searchWorkouts(searchModel: Components.Schemas.SearchWorkoutDto) async throws -> Components.Schemas.PaginatedResultOfGetWorkoutDto
    func postWorkout(_ workout: Components.Schemas.CreateWorkoutDto) async throws -> Components.Schemas.GetWorkoutDto
}
