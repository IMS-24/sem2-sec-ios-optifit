import Foundation

@MainActor
class ExerciseService: ObservableObject {
    
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/exercise"
    
    func fetchExerciseCategories() async throws (ApiError)-> [ExerciseCategoryDto] {
        guard let url = URL(string: "\(baseURL)/categories")
        else {
            throw .invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let exerciseCategories = try decoder.decode([ExerciseCategoryDto].self, from: data)
            return exerciseCategories
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
        }
    }
    
    // Updated search function that supports lazy loading
    func searchExercises(searchModel: SearchExercisesDto) async throws (ApiError) -> PaginatedResult<GetExerciseDto>? {
        guard let url = URL(string: "\(baseURL)/search") else {
            throw .invalidURL
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(searchModel)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(PaginatedResult<GetExerciseDto>.self, from: data)
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
        }
    }
    
    func postExercise(_ exercise: CreateExerciseDto) async throws (ApiError) -> GetExerciseDto {
        guard let url = URL(string: "\(baseURL)") else {
            throw .invalidURL
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(exercise)
            
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(GetExerciseDto.self, from: data)
            
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
            
        }
    }
    
    func deleteExercise(exerciseId: UUID) async throws (ApiError) -> Bool {
        guard let url = URL(string: "\(baseURL)/\(exerciseId)") else {
            throw .invalidURL
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
