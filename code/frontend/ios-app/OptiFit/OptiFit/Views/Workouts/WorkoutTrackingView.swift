import SwiftUI

struct WorkoutTrackingView: View {
    let gym: Gym
    let exerciseCategory: ExerciseCategoryDto
    let workoutStartDate: Date
    
    @State private var performedExercises: [PerformedExercise] = []
    @State private var navigateToExerciseSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("\(exerciseCategory.i18NCode) - Day at \(gym.name) started at \(formattedStartTime)")
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
                    navigateToExerciseSheet = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
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
        .sheet(isPresented: $navigateToExerciseSheet) {
            NavigationStack {
                ExerciseSelectionView(
                    exerciseCategoryId: exerciseCategory.id,
                    onExerciseSelected: { performedExercise in
                        performedExercises.append(performedExercise)
                        navigateToExerciseSheet = false
                    }
                )
            }
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
    // Dummy preview using sample gym and exercise category.
    WorkoutTrackingView(
        gym: Gym(address: "Daham", zipCode: 8020, id: UUID(), name: "Downtown Gym", city: "Graz"),
        exerciseCategory: ExerciseCategoryDto(id: UUID(), i18NCode: "Strength", exerciseIds: []),
        workoutStartDate: Date()
    )
}
