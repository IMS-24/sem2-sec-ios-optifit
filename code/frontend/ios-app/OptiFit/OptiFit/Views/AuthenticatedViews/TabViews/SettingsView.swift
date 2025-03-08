import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showDeleteAlert = false
    @EnvironmentObject private var userProfileViewModel: UserProfileViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @MainActor
    func fetchData() async {
        // Safely unwrap the accessToken before proceeding
        guard let token = authViewModel.accessToken else { return }
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
    static var authViewModel: AuthViewModel {
        let x = AuthViewModel()
            x.accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ilg1ZVhrNHh5b2pORnVtMWtsMll0djhkbE5QNC1jNTdkTzZRR1RWQndhTmsiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiI0ZTg4M2NhMC0xZDI5LTRhNjEtYWI0OS1kMjU5YjQ0OGI1NjQiLCJpc3MiOiJodHRwczovL29wdGlmMXQuYjJjbG9naW4uY29tL2VkZGE4NWVmLWM5YmItNDkzMC04Mjc5LTEyYjRlNTc2NzZmMi92Mi4wLyIsImV4cCI6MTc0MTM3MDIzNywibmJmIjoxNzQxMzY2NjM3LCJzdWIiOiIwYTk4OGM2ZC00NjM2LTQ3MjktOTlhNC0yMTU1NmFhYjM2YmUiLCJnaXZlbl9uYW1lIjoiR3ltIiwiZmFtaWx5X25hbWUiOiJHbm9tZSIsIm5hbWUiOiJHeW1Hbm9tZSIsImVtYWlscyI6WyJvcHRpZml0QG1zdG9lZ2VyZXIubmV0Il0sInRmcCI6IkIyQ18xX3N1c2kiLCJzY3AiOiJQcm9maWxlLlJlYWQiLCJhenAiOiIyODRhZTZiMy04YmQ4LTQ3Y2ItOWFiMS05OGU3NGY0NDQxZGIiLCJ2ZXIiOiIxLjAiLCJpYXQiOjE3NDEzNjY2Mzd9.EjkSlndYMbxIkA7H0A2QjomIPDJRsBtun8aR_kUUT14v-NvSrk1AORWW-jnbE_Q9sZ_XSq0xz9VBGmUUyJqqiZ4sCd6WkvgmO2-0wMp094WSOh3FR9r8uK_SgeIrdJdzAktkvkmcIV1kUP-bz3qcC4mqakpo4cIDfOAi8XWnAMFunNMa8CyDoqi_Ay_vZDawfZVFcAmfYKCaRmk_GJQyPhIIX3orpLwO7viVOxnD0AuCWGa3fmXw-k3B-ouPgEBCkSh3TkT42Qfes3xx7U6ueKwPFMpvcRqM7Rwb7o7W39ZZabNcU4L415sUXFod5K6nSrhvsabxlV5dbusFnJ1-bA"
        print("Model initialized")
        return x
        
    }
    static var previews: some View {
        SettingsView()
            .environmentObject(authViewModel)
            .environmentObject(UserProfileViewModel())
    }
}
