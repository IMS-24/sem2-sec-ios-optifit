import Foundation

@MainActor
class WorkoutService: ObservableObject {
    @Published var workouts: [GetWorkoutDto] = []
    
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/workout"
    
    func searchWorkouts(searchModel: SearchWorkoutsDto, append: Bool = false) async throws (ApiError) -> PaginatedResult<GetWorkoutDto>? {
        guard let url = URL(string: "\(baseURL)/search")
        else {
            throw ApiError.invalidURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let encoder = ISO8601CustomCoder.makeEncoder()
            request.httpBody = try encoder.encode(searchModel)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                print("Request failed with status code: \(httpResponse.statusCode)")
                throw ApiError.requestFailed
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON string: \(jsonString)")
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
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = ISO8601CustomCoder.makeEncoder()
            let jsonData = try encoder.encode(workout)
            print("Request JSON:", String(data: jsonData, encoding: .utf8) ?? "nil")
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                print("Server returned:", httpResponse.statusCode)
                throw ApiError.requestFailed
            }
            
            let decoder = ISO8601CustomCoder.makeDecoder()
            return try decoder.decode(GetWorkoutDto.self, from: data)
        } catch {
            throw ApiError.decodingFailed
        }
    }
}
