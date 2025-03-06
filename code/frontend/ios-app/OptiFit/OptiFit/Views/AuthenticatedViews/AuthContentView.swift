//
//  AuthContentView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 06.03.25.
//

import SwiftUI

struct AuthContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationBarView()
        }
    }
struct NavigationBarView: View {
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
