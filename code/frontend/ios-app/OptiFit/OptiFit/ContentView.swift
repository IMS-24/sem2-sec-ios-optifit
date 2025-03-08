import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var profileViewModel = UserProfileViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isLoggedIn() != false {
                AuthContentView()
                    .environmentObject(profileViewModel)
            } else {
                LoginView()
                    .environmentObject(profileViewModel)
            }
        }
        .onChange(of: authViewModel.initUserProfile) { oldProfile,newProfile in
            // When authViewModel.profile is updated, update the user profile.
            if let newProfile = newProfile {
                Task{
                    await   profileViewModel.initializeProfile(newProfile,token: authViewModel.accessToken!)
                }
            }else{
                    profileViewModel.unsetProfile()
                }
            }
        .animation(.easeInOut, value: authViewModel.accessToken)
    }
       
}

#Preview {
    ContentView()
}
