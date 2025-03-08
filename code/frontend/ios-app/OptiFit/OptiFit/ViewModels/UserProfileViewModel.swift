import Foundation
import SwiftUI
import Combine

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var profile: UserProfileDto?
    @Published var stats: UserStatsDto?
    @Published var errorMessage: ErrorMessage?
    @Published var workoutSummary: [WorkoutSummary] = []
    @Published var isLoading: Bool = false
    @Published var oId: UUID?

    private let profileService = ProfileService()

    func loadStats(token: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let fetchedStats = try await profileService.getStats(token: token)
            self.stats = fetchedStats
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func loadProfile(token: String) async {
        isLoading = true
        errorMessage = nil
        do {
           
            let fetchedProfile = try await profileService.fetchProfile(accessToken: token)
                self.profile = fetchedProfile
          
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func setProfile(_ profile:UserProfileDto){
        self.profile = profile
    }
    func  unsetProfile(){
        self.profile = nil
    }

    func updateProfile(profileToUpdate:UpdateUserProfileDto, token: String) async {
        
        isLoading = true
        errorMessage = nil

        do {
            let result = try await profileService.updateProfile(profile: profileToUpdate, accessToken: token)
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
    
    func initializeProfile(_ profile: UserProfileInitializeDto,token: String) async {
        isLoading = true
        errorMessage = nil
        do{
            let profile = try await profileService.initializeUserProfile(profile,token:token)
            self.profile = profile
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
}
