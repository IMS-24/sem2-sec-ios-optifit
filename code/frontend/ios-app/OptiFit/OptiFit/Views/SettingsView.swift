//
//  SettingsView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showDeleteAlert = false
    @StateObject private var userProfileViewModel = UserProfileViewModel()
    var body: some View {
        NavigationView {
            List {
                // Profile Section
                ProfileView(profile: userProfileViewModel.profile)

                // Base Data Management
                Section(header: Text("Base Data Management")) {
                    BaseDataManagement()
                }

                // Theming
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }

                // User Data Management
                Section(header: Text("Data & Privacy")) {
                    Button("Delete All Data", role: .destructive) {
                        showDeleteAlert = true
                    }
                }
                        .alert("Are you sure?", isPresented: $showDeleteAlert) {
                            Button("Cancel", role: .cancel) {
                            }
                            Button("Delete", role: .destructive) {

                            }
                        }

                // Support
                Section(header: Text("Support")) {
                    Button("Contact Support") {

                    }
                    Text("App Version: " + "1.0.0")
                            .font(.footnote)
                            .foregroundColor(.gray)
                }
            }
                    .navigationTitle("Settings")
                    .onAppear {
                        Task {
                            await userProfileViewModel.loadProfile()
                        }
                    }
                    .alert(item: $userProfileViewModel.errorMessage) { error in
                        Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                    }
        }
    }
}

#Preview {
    SettingsView()
}
