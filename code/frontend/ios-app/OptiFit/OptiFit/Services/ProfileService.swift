import SwiftUI
import Foundation
@MainActor
class ProfileService :ObservableObject{
    private let baseURL = "Profile"
    private let apiClient: APIClient = APIClient()

    func fetchProfile() async throws -> UserProfileDto {
        return try await apiClient.request(endpoint: "\(baseURL)",method: .init("GET"))
    }
    
    func updateProfile(profile: UpdateUserProfileDto) async throws -> UserProfileDto {
        return try await apiClient.request(endpoint: "\(baseURL)",method:.init("PUT"),body:profile)
    }
    
    func deleteProfile(userId: UUID) async throws -> Bool {
        return try await apiClient.request(endpoint: "\(baseURL)", method: .init("DELETE"))
    }
    
    
    func getStats() async throws  -> UserStatsDto {
        return try await apiClient.request(endpoint: "\(baseURL)/stats", method: .init("GET"))
    }
    
    func initializeUserProfile(_ profile: UserProfileInitializeDto) async throws  -> UserProfileDto{
        return try await apiClient.request(endpoint: "\(baseURL)/initialize", method: .init("POST"),body:profile)
    }
}
