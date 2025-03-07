//
//  AuthContentView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 06.03.25.
//

import SwiftUI
import AVFoundation
struct AuthContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
    @State private var showOnboarding = false
    
    var body: some View {
        NavigationStack { // Wrap everything in a NavigationStack
            NavigationBarView()
                .onAppear {
                    if let user = authViewModel.user, user.firstLogin {
                        showOnboarding = true
                    }
                }
//                .fullScreenCover(isPresented: $showOnboarding) {
//                    OnboardingWizardView()
//                }
        }
    }
}


struct NavigationBarView: View {
    @StateObject private var idleTimerManager = IdleTimerManager.shared
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
                    
            }
            Tab("Workouts", systemImage: "gym.bag.fill") {
                WorkoutView()
                   
            }
            Tab("Exercises", systemImage: "dumbbell.fill") {
                ExerciseView()
                  
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
                   
            }
        }
    }
}

struct previewWrapper:View{
    var body: some View {
        NavigationBarView()
    }
    
}
#Preview{previewWrapper()}
