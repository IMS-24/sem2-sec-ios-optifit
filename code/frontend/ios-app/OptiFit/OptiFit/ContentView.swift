//
//  ContentView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        HStack {
//            WelcomePage(appTitle: "OptiFit", appVersion: "Beta V1.0.0")

//            }
        NavigationBarView()
    }
}

#Preview {
    ContentView()
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
