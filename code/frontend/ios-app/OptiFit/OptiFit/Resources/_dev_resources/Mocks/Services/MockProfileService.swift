import SwiftUI

final class MockProfileService: ProfileServiceProtocol, @unchecked Sendable {
    func fetchProfile() async throws -> Components.Schemas.UserProfileDto {
        guard let url = Bundle.main.url(forResource: "MockProfil", withExtension: "json") else {
            throw NSError(domain: "MockProfileService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockProfil.json file not found"])
        }
        let data = try Data(contentsOf: url)
        print("[DEBUG] - Raw Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.UserProfileDto.self, from: data)
        return result
    }

    func updateProfile(profile: Components.Schemas.UpdateUserProfileDto) async throws -> Components.Schemas.UserProfileDto {
        guard let url = Bundle.main.url(forResource: "MockProfil", withExtension: "json") else {
            throw NSError(domain: "MockProfileService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockProfil.json file not found"])
        }
        let data = try Data(contentsOf: url)
        print("[DEBUG] - Raw Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.UserProfileDto.self, from: data)
        return result
    }

    func deleteProfile() async throws -> Bool {
        return true
    }

    func getStats() async throws -> Components.Schemas.UserStatsDto {
        guard let url = Bundle.main.url(forResource: "MockProfilStats", withExtension: "json") else {
            throw NSError(domain: "MockProfileService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockProfilStats.json file not found"])
        }
        let data = try Data(contentsOf: url)
        print("[DEBUG] - Raw Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.UserStatsDto.self, from: data)
        return result
    }

    func initializeUserProfile(_ profile: Components.Schemas.InitializeUserProfileDto) async throws -> Components.Schemas.UserProfileDto {
        guard let url = Bundle.main.url(forResource: "MockInitializeProfile", withExtension: "json") else {
            throw NSError(domain: "MockProfileService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockInitializeProfile.json file not found"])
        }
        let data = try Data(contentsOf: url)
        print("[DEBUG] - Raw Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.UserProfileDto.self, from: data)
        return result
    }

}
