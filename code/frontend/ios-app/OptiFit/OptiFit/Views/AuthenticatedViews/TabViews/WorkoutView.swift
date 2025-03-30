import SwiftUI

struct WorkoutView: View {
    @StateObject var workoutViewModel: WorkoutViewModel
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
    
    // Sorted list of month keys.
    private var sortedMonths: [String] {
        groupedWorkouts.keys.sorted(by: >)
    }
    
    var body: some View {
        NavigationStack {
//            List {
//                ForEach(sortedMonths, id: \.self) { month in
//                    Section(
//                        header: Text(month)
//                            .font(.headline)
//                            .foregroundColor(Color(.primaryText))
//                    ) {
//                        if let workouts = groupedWorkouts[month] {
//                            ForEach(workouts) { workout in
//                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
//                                    WorkoutListEntryView(workout: workout)
//                                }
//                                .onAppear {
//                                    // Check if this workout is the last in the list before loading more.
//                                    if let lastWorkout = workoutViewModel.workouts.last,
//                                       workout.id == lastWorkout.id {
//                                        Task {
//                                            await workoutViewModel.loadMoreWorkouts()
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("Workouts")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        navigateToStartWorkout = true
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                    .tint(Color(.primaryAccent))
//                }
//            }
//            .navigationDestination(isPresented: $navigateToStartWorkout) {
//                WorkoutStartView()
//            }
//            .onAppear {
//                Task {
//                    await workoutViewModel.searchWorkouts()
//                }
//            }
//            .alert(item: $workoutViewModel.errorMessage) { error in
//                Alert(
//                    title: Text("Error"),
//                    message: Text(error.message),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
        }
        .background(Color(.primaryBackground).ignoresSafeArea())
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static let workoutViewModel: WorkoutViewModel = WorkoutViewModel()
    static var previews: some View {
        WorkoutView(workoutViewModel: workoutViewModel)
    }
}
