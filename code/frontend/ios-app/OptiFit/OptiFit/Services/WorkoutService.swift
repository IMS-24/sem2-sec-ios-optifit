import Foundation

@MainActor
class WorkoutService: ObservableObject {
    @Published var workouts: [GetWorkoutDto] = []
    private let apiClient: APIClient = APIClient()

    private let baseURL = "workout"

    func searchWorkouts(searchModel: SearchWorkoutsDto) async throws -> PaginatedResult<GetWorkoutDto>? {
        return try await apiClient.request(endpoint: "\(baseURL)/search", method: .init("POST"), body: searchModel)
    }

    func postWorkout(_ workout: CreateWorkoutDto) async throws -> GetWorkoutDto {
        return try await apiClient.request(endpoint: "\(baseURL)", method: .init("POST"), body: workout)
    }
}
