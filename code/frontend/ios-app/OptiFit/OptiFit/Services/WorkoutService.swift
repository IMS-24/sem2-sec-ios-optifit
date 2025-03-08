import Foundation

@MainActor
class WorkoutService: ObservableObject {
    @Published var workouts: [GetWorkoutDto] = []
    let service = "net.qb8s.optifit"  // A unique identifier for your service
    let account = "jwtToken"                 // Key under which the token is stored
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/workout"
    
    func searchWorkouts(searchModel: SearchWorkoutsDto) async throws (ApiError) -> PaginatedResult<GetWorkoutDto>? {
        guard let url = URL(string: "\(baseURL)/search")
        else {
            throw ApiError.invalidURL
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addAuthorizationHeader(with: token)
            let encoder = ISO8601CustomCoder.makeEncoder()
            request.httpBody = try encoder.encode(searchModel)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    break
                case 400:
                    throw ApiError.badRequest(String(data: data, encoding: .utf8))
                case 401:
                    throw ApiError.unauthorized(String(data: data, encoding: .utf8))
                case 500:
                    throw ApiError.serverError(String(data: data, encoding: .utf8))
                default:
                    throw ApiError.requestFailed
                }
            }            
            let decoder = ISO8601CustomCoder.makeDecoder()
            return try decoder.decode(PaginatedResult<GetWorkoutDto>.self, from: data)
            
        } catch {
            if error is DecodingError {
                throw ApiError.decodingFailed
            } else {
                throw ApiError.requestFailed
            }
        }
    }
    
    func postWorkout(_ workout: CreateWorkoutDto) async throws (ApiError) -> GetWorkoutDto {
        guard let url = URL(string: baseURL) else {
            throw ApiError.invalidURL
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addAuthorizationHeader(with: token)

        do {
            let encoder = ISO8601CustomCoder.makeEncoder()
            let jsonData = try encoder.encode(workout)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                print("Server returned:", httpResponse.statusCode)
                print("Server response:" , String(data: data, encoding: .utf8) ?? String("<No Data>"))
                throw ApiError.requestFailed
            }
            
            let decoder = ISO8601CustomCoder.makeDecoder()
            return try decoder.decode(GetWorkoutDto.self, from: data)
        } catch {
            if error is DecodingError {
                throw ApiError.decodingFailed
            }
            else{
                throw ApiError.requestFailed
            }
            
        }
    }
}
