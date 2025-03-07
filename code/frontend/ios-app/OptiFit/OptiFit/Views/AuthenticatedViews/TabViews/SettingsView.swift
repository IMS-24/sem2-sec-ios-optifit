import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showDeleteAlert = false
    @StateObject private var userProfileViewModel = UserProfileViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            List {
                // Profile Section
                ProfileView()
                
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
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        // Delete action here
                    }
                }
                
                // Support
                Section(header: Text("Support")) {
                    Button("Contact Support") {
                        // Contact support action here
                    }
                    Text("App Version: " + "1.0.0")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .refreshable {
                // Pull-to-refresh action
                await userProfileViewModel.loadProfile(token: authViewModel.accessToken!)
            }
            .navigationTitle("Settings")
            .onAppear {
                Task {
                    await userProfileViewModel.loadProfile(token: authViewModel.accessToken!)
                }
            }
            .alert(item: $userProfileViewModel.errorMessage) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    SettingsView()
}
