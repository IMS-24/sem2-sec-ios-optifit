import Foundation

@MainActor
class ExerciseService: ObservableObject {
    private let apiClient: APIClient = APIClient()
    private let baseURL = "exercise"

    func fetchExerciseCategories() async throws -> [ExerciseCategoryDto] {
        return try await apiClient.request(endpoint: "\(baseURL)/categories")
    }

    func fetchExerciseStatistics(exerciseId: UUID) async throws -> GetExerciseStatisticsDto {
        return try await apiClient.request(endpoint: "\(baseURL)/\(exerciseId)/stats", method: .init("GET"))
    }

    func searchExercises(searchModel: SearchExercisesDto) async throws -> PaginatedResult<GetExerciseDto> {
        return try await apiClient.request(endpoint: "\(baseURL)/search", method: .init("POST"), body: searchModel)
    }

    func postExercise(_ exercise: CreateExerciseDto) async throws -> GetExerciseDto {
        return try await apiClient.request(endpoint: "\(baseURL)", method: .init("POST"), body: exercise)
    }

    func updateExercise(exerciseId: UUID, exercise: UpdateExerciseDto) async throws -> GetExerciseDto {
        return try await apiClient.request(endpoint: "\(baseURL)/\(exerciseId)", method: .init("PUT"), body: exercise)
    }

    func deleteExercise(exerciseId: UUID) async throws -> UUID {
        return try await apiClient.request(endpoint: "\(baseURL)/\(exerciseId)", method: .init("DELETE"))
    }
}
