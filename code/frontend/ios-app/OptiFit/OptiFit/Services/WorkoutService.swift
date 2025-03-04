import Foundation

@MainActor
class WorkoutService:ObservableObject {
    @Published var workouts: [GetWorkoutDto] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage?
    
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/workout"
    
    func searchWorkouts(searchModel: SearchWorkoutsDto, append: Bool = false) async -> PaginatedResult<GetWorkoutDto>? {
        guard let url = URL(string: "\(baseURL)/search") else {
            errorMessage = ErrorMessage(message: "Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(searchModel)
        } catch {
            errorMessage = ErrorMessage(message: "Failed to encode search request")
            return nil
        }
        
        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [
                .withInternetDateTime,
                .withFractionalSeconds,
                .withColonSeparatorInTimeZone
            ]
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                if let date = isoFormatter.date(from: dateString) {
                    return date
                }
                throw DecodingError.dataCorruptedError(in: container,
                                                       debugDescription: "Cannot decode date string \(dateString)")
            }
            let response = try decoder.decode(PaginatedResult<GetWorkoutDto>.self, from: data)
            if append {
                workouts.append(contentsOf: response.items)
            } else {
                workouts = response.items
            }
            return response
        } catch {
            errorMessage = ErrorMessage(message: "Failed to decode Workout response from server")
            return nil
        }
    }
}
