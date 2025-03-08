import Foundation

@MainActor
class MuscleGroupService: ObservableObject {
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/musclegroup"
    
    func searchMuscleGroups(searchModel: SearchMuscleGroupsDto, token: String) async throws (ApiError)->PaginatedResult<GetMuscleGroupDto> {
        guard let url = URL(string: "\(baseURL)/search")
        else {
            throw .invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addAuthorizationHeader(with: token)
        
        do {
            request.httpBody = try JSONEncoder().encode(searchModel)
        } catch {
            throw .decodingFailed
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = ISO8601CustomCoder.makeDecoder()
            let response = try decoder.decode(PaginatedResult<GetMuscleGroupDto>.self, from: data)
            return response
        } catch {
            throw .requestFailed
        }
    }
}
