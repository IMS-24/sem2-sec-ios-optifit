import SwiftUI

struct WorkoutView: View {
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @State private var navigateToStartWorkout = false
    
    private var groupedWorkouts: [String: [GetWorkoutDto]] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return Dictionary(grouping: workoutViewModel.workouts, by: { formatter.string(from: $0.startAtUtc) })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedWorkouts.keys.sorted(by: { $0 > $1 }), id: \.self) { month in
                    Section(header: Text(month)
                        .font(.headline)
                        .foregroundColor(Color("PrimaryText"))) {
                            
                            ForEach(groupedWorkouts[month] ?? []) { workout in
                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                    WorkoutListEntryView(workout: workout)
                                }
                                .onAppear {
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
                WorkoutStartView()
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
