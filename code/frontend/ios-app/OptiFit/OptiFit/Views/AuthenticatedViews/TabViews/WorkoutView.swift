import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    @State private var navigateToStartWorkout = false
    
    // Group workouts by month.
    private var groupedWorkouts: [String: [Components.Schemas.GetWorkoutDto]] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        let workouts = workoutViewModel.workouts
        
        // Group by month string, using "Unknown" if startAtUtc is nil.
        let grouped = Dictionary(grouping: workouts) { workout -> String in
            if let startDate = workout.startAtUtc {
                return formatter.string(from: startDate)
            } else {
                return "Unknown"
            }
        }
        return grouped
    }
    
    var body: some View {
        NavigationStack {
            List {
                GroupedWorkoutListView(groupedWorkouts: groupedWorkouts)
            }
            .refreshable {
                await workoutViewModel.searchWorkouts()
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        navigateToStartWorkout = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .tint(Color(.primaryAccent))
                }
            }
            .navigationDestination(isPresented: $navigateToStartWorkout) {
                WorkoutStartView()
            }
            .onAppear {
                Task {
                    await workoutViewModel.searchWorkouts()
                }
            }
            .alert(item: $workoutViewModel.errorMessage) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .background(Color(.primaryBackground).ignoresSafeArea())
    }
}
