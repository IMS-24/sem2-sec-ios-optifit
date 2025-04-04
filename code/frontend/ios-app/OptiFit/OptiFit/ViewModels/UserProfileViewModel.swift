import Combine
import Foundation
import SwiftUI

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var profile: Components.Schemas.UserProfileDto?
    @Published var stats: Components.Schemas.UserStatsDto?
    @Published var errorMessage: ErrorMessage?
    @Published var workoutSummary: [Components.Schemas.WorkoutSummary] = []
    @Published var isLoading: Bool = false
    @Published var oId: UUID?

    private let profileService: ProfileServiceProtocol
    
    init(profileService: ProfileServiceProtocol = ProfileService()) {
        self.profileService = profileService
    }

    func loadStats() async {
        isLoading = true
        errorMessage = nil
        do {
            let fetchedStats = try await profileService.getStats()
            self.stats = fetchedStats
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func loadProfile() async {
        isLoading = true
        errorMessage = nil
        do {

            let fetchedProfile = try await profileService.fetchProfile()
            self.profile = fetchedProfile

        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func setProfile(_ profile: Components.Schemas.UserProfileDto) {
        self.profile = profile
    }
    func unsetProfile() {
        self.profile = nil
    }

    func updateProfile(profileToUpdate: Components.Schemas.UpdateUserProfileDto) async {

        isLoading = true
        errorMessage = nil

        do {
            let result = try await profileService.updateProfile(profile: profileToUpdate)
            self.profile = result

        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)

        }
        isLoading = false

    }

    func deleteProfile() async {
        guard profile != nil else {
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let success = try await profileService.deleteProfile()
            if success {
                self.profile = nil
            } else {
                self.errorMessage = ErrorMessage(message: "Failed to delete user.")
            }
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func initializeProfile(_ profile: Components.Schemas.InitializeUserProfileDto) async {
        isLoading = true
        errorMessage = nil
        do {
            let profile = try await profileService.initializeUserProfile(profile)
            self.profile = profile
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
}
