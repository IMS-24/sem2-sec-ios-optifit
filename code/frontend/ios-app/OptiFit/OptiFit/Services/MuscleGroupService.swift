import Foundation

@MainActor
class MuscleGroupService: ObservableObject {
    private let apiClient: APIClient = APIClient()
    private let baseURL = "musclegroup"

    func searchMuscleGroups(searchModel: SearchMuscleGroupsDto) async throws -> PaginatedResult<GetMuscleGroupDto> {
        return try await apiClient.request(endpoint: "\(baseURL)/search", method: .init("POST"), body: searchModel)

    }
}
