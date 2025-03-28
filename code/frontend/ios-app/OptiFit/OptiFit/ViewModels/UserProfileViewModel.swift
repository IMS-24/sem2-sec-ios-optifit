import Combine
import Foundation
import SwiftUI

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var profile: UserProfileDto?
    @Published var stats: UserStatsDto?
    @Published var errorMessage: ErrorMessage?
    @Published var workoutSummary: [WorkoutSummary] = []
    @Published var isLoading: Bool = false
    @Published var oId: UUID?

    private let profileService = ProfileService()

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

    func setProfile(_ profile: UserProfileDto) {
        self.profile = profile
    }
    func unsetProfile() {
        self.profile = nil
    }

    func updateProfile(profileToUpdate: UpdateUserProfileDto) async {

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
        guard let currentUser = profile else {
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let success = try await profileService.deleteProfile(userId: currentUser.id)
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

    func initializeProfile(_ profile: UserProfileInitializeDto) async {
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
