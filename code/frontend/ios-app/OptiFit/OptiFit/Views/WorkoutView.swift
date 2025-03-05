import SwiftUI

struct WorkoutView: View {
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @State private var navigateToStartWorkout = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Start Workout") {
                    navigateToStartWorkout = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal)
                .padding(.top)
                
                // Workout History List
                List(workoutViewModel.workouts) { workout in
                    NavigationLink {
                        WorkoutDetailView(workout: workout)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(DateFormatter.localizedString(from: workout.startAtUtc,
                                                               dateStyle: .medium,
                                                               timeStyle: .short))
                            .font(.headline)
                            
                            Text(workout.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            if let notes = workout.notes, !notes.isEmpty {
                                Text(notes)
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }

            .navigationTitle("Workouts")
            .onAppear {
                Task {
                    await workoutViewModel.searchWorkouts()
                }
            }
            .alert(item: $workoutViewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(isPresented: $navigateToStartWorkout) {
                StartWorkoutView()
            }
        }
    }
}

#Preview {
    WorkoutView()
}
