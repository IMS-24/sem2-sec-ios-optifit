import SwiftUI

struct WorkoutView: View {
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @State private var navigateToStartWorkout = false
    
    // Group workouts by month, using the month and year as key.
    private var groupedWorkouts: [String: [GetWorkoutDto]] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"  // e.g., "Mar 2025"
        return Dictionary(grouping: workoutViewModel.workouts, by: { formatter.string(from: $0.startAtUtc) })
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Iterate over each month group (sorted so the latest months appear first)
                ForEach(groupedWorkouts.keys.sorted(by: { $0 > $1 }), id: \.self) { month in
                    Section(header:
                                Text(month)
                        .font(.headline)
                        .foregroundColor(Color("PrimaryText"))
                    ) {
                        ForEach(groupedWorkouts[month] ?? []) { workout in
                            NavigationLink {
                                WorkoutDetailView(workout: workout)
                            } label: {
                                WorkoutListEntryView(workout: workout)
                            }
                            .onAppear {
                                // If this workout is the last one, load more workouts.
                                if workout == workoutViewModel.workouts.last {
                                    Task {
                                        await workoutViewModel.loadMoreWorkouts()
                                    }
                                }
                            }
                        }
                    }
                }
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
                    .tint(Color("PrimaryAccent"))
                }
            }
            .navigationDestination(isPresented: $navigateToStartWorkout) {
                StartWorkoutView()
            }
            .onAppear {
                Task {
                    await workoutViewModel.searchWorkouts()
                }
            }
            .alert(item: $workoutViewModel.errorMessage) { error in
                Alert(title: Text("Error"),
                      message: Text(error.message),
                      dismissButton: .default(Text("OK")))
            }
        }
        .background(Color("PrimaryBackground").ignoresSafeArea())
    }
}

#Preview {
    WorkoutView()
}
