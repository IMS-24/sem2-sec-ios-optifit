import SwiftUI

protocol ProfileServiceProtocol: Sendable {
    func fetchProfile() async throws -> Components.Schemas.UserProfileDto

    func updateProfile(profile: Components.Schemas.UpdateUserProfileDto) async throws -> Components.Schemas.UserProfileDto

    func deleteProfile() async throws -> Bool

    func getStats() async throws -> Components.Schemas.UserStatsDto

    func initializeUserProfile(_ profile: Components.Schemas.InitializeUserProfileDto) async throws -> Components.Schemas.UserProfileDto
}
