import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

@MainActor
class ProfileService: ObservableObject {
    var baseUrl = AppConfiguration.apiBaseURL
    let configuration = Configuration(
        dateTranscoder: DotNetDateTranscoder()
    )
    let client: Client

    init() {
        client = Client(
            serverURL: baseUrl,
            configuration: configuration,
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware()]
        )
    }

    func fetchProfile() async throws -> Components.Schemas.UserProfileDto {
        let result = try await client.Profile_GetUserProfile()
        return try result.ok.body.json
    }

    func updateProfile(profile: Components.Schemas.UpdateUserProfileDto) async throws -> Components.Schemas.UserProfileDto {
        let result = try await client.Profile_UpdateUserProfile(.init(body: .json(profile)))
        return try result.ok.body.json
    }

    func deleteProfile() async throws -> Bool {
        let _ = try await client.Profile_DeleteUserProfile()
        return true
    }

    func getStats() async throws -> Components.Schemas.UserStatsDto {
        let result = try await client.Profile_GetUserStats()
        return try result.ok.body.json
    }

    func initializeUserProfile(_ profile: Components.Schemas.InitializeUserProfileDto) async throws -> Components.Schemas.UserProfileDto {
        let result = try await client.Profile_InitializeUserProfile(.init(body: .json(profile)))
        return try result.ok.body.json
    }
}
