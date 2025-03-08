import Foundation

@MainActor
class ExerciseService: ObservableObject {
   // private let GetExerciseStatisticsDto: GetExerciseStatisticsDto
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/exercise"
    
    let service = "net.qb8s.optifit"  // A unique identifier for your service
    let account = "jwtToken"                 // Key under which the token is stored
    
    
    func fetchExerciseCategories() async throws (ApiError)-> [ExerciseCategoryDto] {
        guard let url = URL(string: "\(baseURL)/categories")
        else {
            throw .invalidURL
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addAuthorizationHeader(with: token)
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
    
    func fetchExerciseStatistics(exerciseId: UUID) async throws (ApiError) -> GetExerciseStatisticsDto{
        guard let url = URL(string: "\(baseURL)/\(exerciseId)/stats")
        else {
            throw .invalidURL
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addAuthorizationHeader(with: token)
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
            let exerciseCategories = try decoder.decode(GetExerciseStatisticsDto.self, from: data)
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
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addAuthorizationHeader(with: token)
            request.httpBody = try JSONEncoder().encode(searchModel)
            
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
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addAuthorizationHeader(with: token)
            
            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(exercise)
            
            
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
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.addAuthorizationHeader(with: token)
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
