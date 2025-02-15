import SwiftUI

struct WorkoutView: View {
    @State private var workouts: [Workout] = sampleWorkouts // Replace with a real data source
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
                List(workouts.sorted(by: { $0.date > $1.date })) { workout in
                    VStack(alignment: .leading) {
                        Text(workout.dateFormatted)
                            .font(.headline)
                        
                        HStack {
                            Text("Sets: \(workout.totalSets)")
                            Text("Reps: \(workout.totalReps)")
                            Text("Weight: \(workout.totalWeight, specifier: "%.1f") kg")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        
                        Text("Exercises: \(workout.exercises.count)")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Workouts")
            .navigationDestination(isPresented: $navigateToStartWorkout) {
                StartWorkoutView()
            }
        }
    }
}

// Sample data and preview
let sampleWorkouts: [Workout] = [
    Workout(
        date: Date(),
        exercises: [ExerciseStat(name: "Bench Press", sets: 3, reps: 10, weight: 80.0)]
    ),
    Workout(
        date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
        exercises: [ExerciseStat(name: "Squat", sets: 4, reps: 8, weight: 100.0)]
    )
]

#Preview {
    WorkoutView()
}
