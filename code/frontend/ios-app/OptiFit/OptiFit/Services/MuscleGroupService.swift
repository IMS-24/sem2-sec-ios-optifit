import Foundation

@MainActor
class MuscleGroupService: ObservableObject {
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/musclegroup"

    func searchMuscleGroups(searchModel: SearchMuscleGroupsDto) async throws (ApiError)->PaginatedResult<GetMuscleGroupDto>{
        guard let url = URL(string: "\(baseURL)/search") else {
            throw .invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(searchModel)
        } catch {
            throw .decodingFailed
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(PaginatedResult<GetMuscleGroupDto>.self, from: data)
            return response
        } catch {
            throw .requestFailed
        }
    
    }
}
