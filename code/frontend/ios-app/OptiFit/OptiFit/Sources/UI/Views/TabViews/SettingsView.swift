import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showDeleteAlert = false
    @EnvironmentObject private var userProfileViewModel: UserProfileViewModel

    @MainActor
    func fetchData() async {
        await userProfileViewModel.loadProfile()
    }

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
                    Button("Cancel", role: .cancel) {}
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
                await fetchData()
            }
            .navigationTitle("Settings")
            .onAppear {
                Task {
                    await fetchData()
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

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsView()
            .environmentObject(UserProfileViewModel())
    }
}
