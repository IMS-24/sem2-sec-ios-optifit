
import Foundation

@MainActor
class MuscleService: ObservableObject {
    private let baseURL = "muscle"
    private let apiClient: APIClient = APIClient()

    
    func searchMuscles(searchModel: SearchMusclesDto) async throws -> PaginatedResult<GetMuscleDto> {
        return try await apiClient.request(endpoint: "\(baseURL)/search",method:.init("POST"),body:searchModel)
    }
}
