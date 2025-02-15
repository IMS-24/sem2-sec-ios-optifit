import SwiftUI

struct WorkoutTrackingView: View {
    let gym: Gym
    let exerciseType: ExerciseType
    let workoutStartDate: Date
    
    @State private var performedExercises: [PerformedExercise] = []
    @State private var isPaused: Bool = false
    @State private var navigateToExerciseSelectionView: Bool = false
    var body: some View {
        VStack {
            Text("\(exerciseType.i18NCode) - Day at \(gym.name) started at \(formattedStartTime)")
                .font(.headline)
                .padding()
            
            if performedExercises.isEmpty {
                Text("No exercises performed yet.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(performedExercises) { exercise in
                        Text(exercise.name)
                    }
                }
            }
            
            HStack(spacing: 20) {
                Button("Add Exercise") {
                    
                    navigateToExerciseSelectionView = true
                    // TODO: Navigate to exercise selection view.
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
//                Button(isPaused ? "Resume" : "Pause") {
//                    isPaused.toggle()
//                }
//                .buttonStyle(.bordered)
//                .controlSize(.large)
//                
                Button("End Workout") {
                    // TODO: End the workout (pop view or save workout).
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Track Workout")
        .navigationDestination(isPresented: $navigateToExerciseSelectionView){
            ExerciseSelectionView(exerciseTypeId: exerciseType.id)
        }
    }
    
    // Format the start time for display.
    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: workoutStartDate)
    }
}

#Preview {
    // Dummy preview using sample gym and exercise type.
    WorkoutTrackingView(
        gym: Gym(address: "Daham", zipCode: 8020, id:  UUID(),name: "Downtown Gym",city: "Graz"),
        exerciseType: ExerciseType(id: UUID(), i18NCode: "Strength",exercises: []),
        workoutStartDate: Date()
    )
}
