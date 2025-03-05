import Foundation

@MainActor
class WorkoutService: ObservableObject {
    @Published var workouts: [GetWorkoutDto] = []
    
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/workout"
    
    /// A DateFormatter that matches the backend’s ISO8601 output:
    /// e.g. "2025-03-05T09:29:48.502+00:00"
    private var isoCustomFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    func searchWorkouts(searchModel: SearchWorkoutsDto, append: Bool = false) async throws(ApiError) -> PaginatedResult<GetWorkoutDto>? {
        guard let url = URL(string: "\(baseURL)/search") else {
            throw ApiError.invalidURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Encode the search model (using ISO8601 encoding for any dates)
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
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
            
            let decoder = JSONDecoder()
            // Use the custom date decoding strategy with our formatter
            let formatter = isoCustomFormatter
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                if let date = formatter.date(from: dateString) {
                    return date
                }
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot parse date string: \(dateString)"
                )
            }
            
            return try decoder.decode(PaginatedResult<GetWorkoutDto>.self, from: data)
            
        } catch {
            if error is DecodingError {
                throw ApiError.decodingFailed
            } else {
                throw ApiError.requestFailed
            }
        }
    }
    
    func postWorkout(_ workout: CreateWorkoutDto) async throws(ApiError) -> GetWorkoutDto {
        guard let url = URL(string: baseURL) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(workout)
            print("Request JSON:", String(data: jsonData, encoding: .utf8) ?? "nil")
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                print("Server returned:", httpResponse.statusCode)
                throw ApiError.requestFailed
            }
            
            let decoder = JSONDecoder()
            // Use our custom date decoding strategy as above
            let formatter = isoCustomFormatter
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                if let date = formatter.date(from: dateString) {
                    return date
                }
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot parse date string: \(dateString)"
                )
            }
            
            return try decoder.decode(GetWorkoutDto.self, from: data)
        } catch {
            throw ApiError.decodingFailed
        }
    }
}
