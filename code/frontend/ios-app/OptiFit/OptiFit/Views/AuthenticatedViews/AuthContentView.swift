import AVFoundation
import SwiftUI

struct AuthContentView: View {
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
    @StateObject var workoutViewModel: WorkoutViewModel = WorkoutViewModel()
    @StateObject var exerciseViewModel: ExerciseViewModel = ExerciseViewModel()
    @StateObject var exerciseCategoryViewModel: ExerciseCategoryViewModel = ExerciseCategoryViewModel()
    @StateObject var muscleViewModel: MuscleViewModel = MuscleViewModel()
    @StateObject var currentWorkoutViewModel: CurrentWorkoutViewModel = CurrentWorkoutViewModel()

    @State private var showOnboarding = false

    var body: some View {

        NavigationBarView()
            .onAppear {
                if let user = userProfileViewModel.profile, user.initialSetupDone == false {
                    showOnboarding = true
                }
            }
            .environmentObject(workoutViewModel)
            .environmentObject(exerciseViewModel)
            .environmentObject(currentWorkoutViewModel)
            .environmentObject(exerciseCategoryViewModel)
            .environmentObject(muscleViewModel)
        //                .fullScreenCover(isPresented: $showOnboarding) {
        //                    OnboardingWizardView()
        //                }
    }
}

//struct AuthContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthContentView()
//            .environmentObject(UserProfileViewModel())
//    }
//}
