
import SwiftUI
import AVFoundation
struct AuthContentView: View {
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
   
    @State private var showOnboarding = false
    
    var body: some View {
      
            NavigationBarView()
                .onAppear {
                    if let user = userProfileViewModel.profile, userProfileViewModel.profile?.initialSetupDone == false {
                        showOnboarding = true
                    }
                }
//                .fullScreenCover(isPresented: $showOnboarding) {
//                    OnboardingWizardView()
//                }
    }
}


struct NavigationBarView: View {
    @StateObject private var idleTimerManager = IdleTimerManager.shared
    @StateObject var workoutViewModel: WorkoutViewModel = WorkoutViewModel()
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
                    
            }
            Tab("Workouts", systemImage: "gym.bag.fill") {
                WorkoutView(workoutViewModel: workoutViewModel)
                   
            }
            Tab("Exercises", systemImage: "dumbbell.fill") {
                ExerciseView()
                  
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
                   
            }
            Tab("Trainer", systemImage: "figure.strengthtraining.functional"){
                VirtualTrainerView()
            }
        }
    }
}


struct AuthContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthContentView()
            .environmentObject(UserProfileViewModel())
    }
}
