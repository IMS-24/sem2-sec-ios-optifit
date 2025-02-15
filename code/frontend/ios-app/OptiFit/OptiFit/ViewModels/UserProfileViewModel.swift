//
//  UserProfileViewModel.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 22.02.25.
//


import Foundation
import SwiftUI
import Combine

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var profile: UserProfile?
    @Published var stats: UserStatsDto?
    @Published var errorMessage: ErrorMessage?
    private var cancellables = Set<AnyCancellable>()
    
    private let profileService = ProfileService()
    
    init() {
        observeService()
        Task {
            await loadProfile()
            await loadStats()
        }
    }
    
    private func observeService() {
        profileService.$stats
            .sink { [weak self] in
                self?.stats = $0
            }
            .store(in: &cancellables)
        
        profileService.$errorMessage
            .sink { [weak self] in
                self?.errorMessage = $0
            }
            .store(in: &cancellables)
    }
    func loadStats(){
        Task {
            let result = await profileService.getStats()
//            switch result {
//            case .success(let stats):
//                self.stats = stats
//            case .failure(let error):
//                self.errorMessage = ErrorMessage(message: "Failed to load profile: \(error)")
//            }
        }
    }
    func loadProfile() {
        Task {
            let result = await profileService.fetchProfile()
//            switch result {
//            case .success(let profile):
//                self.profile = profile
//            case .failure(let error):
//                self.errorMessage = ErrorMessage(message: "Failed to load profile: \(error)")
//            }
        }
    }
    
    
    func updateProfile(
        firstName: String,
        lastName: String,
        email: String,
        dateOfBirthUtc: Date?,
        initialSetupDone: Bool
    ) {
        guard var profile = profile else {
            return
        }
        profile.firstName = firstName
        profile.lastName = lastName
        profile.email = email
        profile.dateOfBirthUtc = dateOfBirthUtc
        profile.initialSetupDone = initialSetupDone
        
        Task {
            let result = await profileService.updateProfile(profile)
            switch result {
            case .success(let updatedProfile):
                self.profile = updatedProfile
            case .failure(let error):
                self.errorMessage = ErrorMessage(message: "Failed to update profile: \(error)")
            }
        }
    }
    
    func deleteProfile() {
        Task {
            let result = await profileService.deleteProfile()
            switch result {
            case .success:
                self.profile = nil
            case .failure(let error):
                self.errorMessage = ErrorMessage(message: "Failed to delete profile: \(error)")
            }
        }
    }
}
