import SwiftUI

struct NavigationBarView: View {
    //    @StateObject private var idleTimerManager = IdleTimerManager.shared
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
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
            //            Tab("Trainer", systemImage: "figure.strengthtraining.functional") {
            //                VirtualTrainerView()
            //            }
        }
    }
}
