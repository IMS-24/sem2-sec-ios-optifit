//
//  VirtualTrainerViewModel.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class VirtualTrainerViewModel: ObservableObject {
    @Published var isActive: Bool = false
    @Published var currentLevel: Int = 1
    @Published var errorMessage: ErrorMessage?
    @Published var isLoading: Bool = false
    @Published var insult: String?
    @Published var trainerName = "Pepe McMuscle"

    let virtualTrainerService = VirtualTrainerService()
    
    func updateLevel() {
        currentLevel += 1
    }
    func getMotivation(token: String) async {
        isLoading = true
        errorMessage = nil
        do
        {
            let result = try await virtualTrainerService.fetchMotivation(token: token,level: currentLevel)
            updateLevel()
            insult = result.message
            
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
}
