import Foundation
import SwiftUI
import Combine

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var profile: UserProfile?
    @Published var stats: UserStatsDto?
    @Published var errorMessage: ErrorMessage?
    @Published var workoutData: [WorkoutStat] = [
        WorkoutStat(day: "Mon", workoutMinutes: 65),
        WorkoutStat(day: "Tue", workoutMinutes: 100),
        WorkoutStat(day: "Wed", workoutMinutes: 72),
        WorkoutStat(day: "Thu", workoutMinutes: 60),
        WorkoutStat(day: "Fri", workoutMinutes: 90),
        WorkoutStat(day: "Sat", workoutMinutes: 120),
        WorkoutStat(day: "Sun", workoutMinutes: 45)
    ]
    @Published  var isLoading:Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private let profileService = ProfileService()
    
    func loadStats() async{
        isLoading=true
        errorMessage=nil
        do {
            let fetchedStats = try await profileService.getStats()
            self.stats = fetchedStats
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func loadProfile()async {
        isLoading=true
        errorMessage=nil
        do{
            let fetchedProfile = try await profileService.fetchProfile()
            self.profile = fetchedProfile
        }
        catch{
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
    
    
    func updateProfile(
        firstName: String,
        lastName: String,
        email: String,
        dateOfBirthUtc: Date?,
        initialSetupDone: Bool
    ) async {
        guard var profile = profile else {
            return
        }
        isLoading = true
        errorMessage = nil
        profile.firstName = firstName
        profile.lastName = lastName
        profile.email = email
        profile.dateOfBirthUtc = dateOfBirthUtc
        profile.initialSetupDone = initialSetupDone
        
        do {
            let result = try await profileService.updateProfile(profile:profile)
            self.profile = result
            
        }catch{
            self.errorMessage = ErrorMessage(message: error.localizedDescription)

        }
    isLoading = false
        
    }
    
    func deleteProfile() async {
        guard let currentUser = profile else { return }
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
}
