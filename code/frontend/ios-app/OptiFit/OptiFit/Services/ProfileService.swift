//
//  ProfileService.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import Foundation

class ProfileService {
    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/Profile"
    
    @Published var errorMessage: ErrorMessage?
    @Published var stats: UserStatsDto?
    @Published var userProfile: UserProfile?

    func fetchProfile() async  {
        guard let url = URL(string: baseURL) else {
            errorMessage = ErrorMessage(message: "Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
           userProfile = try decoder.decode(UserProfile.self, from: data)
           
        } catch {
            if error is DecodingError {
                errorMessage = ErrorMessage(message: "Failed to decode JSON")
            }
                else{
                    errorMessage = ErrorMessage(message: "Failed to load UserProfile")
                }
            }
    }

    func updateProfile(_ profile: UserProfile) async -> Result<UserProfile, ApiServiceError> {
        guard let url = URL(string: baseURL) else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(profile)
        } catch {
            return .failure(.unknown)
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let updatedProfile = try JSONDecoder().decode(UserProfile.self, from: data)
            return .success(updatedProfile)
        } catch {
            if error is DecodingError {
                return .failure(.decodingFailed)
            }
            return .failure(.requestFailed)
        }
    }

    func deleteProfile() async -> Result<Void, ApiServiceError> {
        guard let url = URL(string: baseURL) else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        do {
            _ = try await URLSession.shared.data(for: request)
            return .success(())
        } catch {
            return .failure(.requestFailed)
        }
    }
    
    func getStats() async {
        guard let url = URL(string: "\(baseURL)/stats") else {
            errorMessage = ErrorMessage(message: "Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            stats = try decoder.decode(UserStatsDto.self, from: data)
            
        } catch {
            if error is DecodingError {
                errorMessage = ErrorMessage(message: "Decoding failed")
                
            }
            
        }
    }
}
