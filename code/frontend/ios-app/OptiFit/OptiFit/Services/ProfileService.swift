import SwiftUI
import Foundation
@MainActor
class ProfileService :ObservableObject{
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/Profile"
    let service = "net.qb8s.optifit"  // A unique identifier for your service
    let account = "jwtToken"                 // Key under which the token is stored
//    func fetchProfileById(_ id: UUID) async throws (ApiError)-> UserProfileDto {
//        guard let url = URL(string: "\(baseURL)/\(id)") else {
//            throw .invalidURL
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let decoder = ISO8601CustomCoder.makeDecoder()
//            let userProfile = try decoder.decode(UserProfileDto.self, from: data)
//            return userProfile
//            
//        } catch {
//            if error is DecodingError {
//                throw .decodingFailed
//            } else {
//                throw .requestFailed
//            }
//        }
//    }
    func fetchProfile() async throws (ApiError)-> UserProfileDto {
        guard let url = URL(string: "\(baseURL)") else {
            throw .invalidURL
            
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addAuthorizationHeader(with: token)
            // handle response error codes
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = ISO8601CustomCoder.makeDecoder()
            let userProfile = try decoder.decode(UserProfileDto.self, from: data)
            return userProfile
            
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
        }
    }
    
    func updateProfile(profile: UpdateUserProfileDto) async throws (ApiError) -> UserProfileDto {
        guard let url = URL(string: "\(baseURL)") else {
            throw .invalidURL
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
        }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addAuthorizationHeader(with: token)

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let encoder = ISO8601CustomCoder.makeEncoder()
            request.httpBody = try encoder.encode(profile)
            // handle response error codes
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = ISO8601CustomCoder.makeDecoder()
            return try decoder.decode(UserProfileDto.self, from: data)
            //return try JSONDecoder().decode(UserProfileDto.self, from: data)
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
        }
    }
    
    func deleteProfile(userId: UUID) async throws (ApiError) -> Bool {
        guard let url = URL(string: "\(baseURL)") else {
            throw .invalidURL
        }
        guard let token = KeychainHelper.shared.readToken(service: service, account: account) else{
            throw .unauthorized("No token found")
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
    
    
    func getStats() async throws (ApiError) -> UserStatsDto {
        guard let url = URL(string: "\(baseURL)/stats") else {
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
            let stats = try decoder.decode(UserStatsDto.self, from: data)
            return stats
            
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
        }
    }
    
    func initializeUserProfile(_ profile: UserProfileInitializeDto) async throws (ApiError) -> UserProfileDto{
        guard let url = URL(string: "\(baseURL)/initialize")else{
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
            let encoder = ISO8601CustomCoder.makeEncoder()
            request.httpBody = try encoder.encode(profile)
            
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
            return try decoder.decode(UserProfileDto.self, from: data)
        } catch {
            if error is DecodingError {
                throw .decodingFailed
            } else {
                throw .requestFailed
            }
        }
    }
}
