import SwiftUI

struct WorkoutTrackingView: View {
    @Environment(\.dismiss) private var dismiss
    let gym: Gym
    let exerciseCategory: ExerciseCategoryDto
    let workoutStartDate: Date
    
    @State private var performedExercises: [PerformedExercise] = []
    @State private var navigateToExerciseSheet: Bool = false
    
    // Create or inject a shared WorkoutViewModel
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            Section(header: Text("Description")) {
                TextEditor(text: $description)
                    .frame(minHeight: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1))
                    .padding(.top, 4)
            }
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
                    .onDelete(perform: deleteExercise)
                    .onMove(perform: moveExercise)
                }
                .listStyle(InsetGroupedListStyle())
              
            }
            
            HStack(spacing: 20) {
                Button("Add Exercise") {
                    navigateToExerciseSheet = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                // Save Button
                Section {
                    Button(action: saveWorkout) {
                        Label("Save", systemImage: "checkmark.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
//                Button("End Workout") {
//                    Task {
//                        // Call the save method on your WorkoutViewModel.
//                        // Adjust the parameters as needed for your implementation.
//                        
//                        await workoutViewModel.saveWorkout(
//                            gym: gym,
//                            exerciseCategory: exerciseCategory,
//                            workoutStartDate: workoutStartDate,
//                            performedExercises: performedExercises
//                        )
//                        // Optionally, dismiss or navigate away after saving.
//                    }
//                }
//                .buttonStyle(.bordered)
//                .controlSize(.large)
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
        .alert(item: $workoutViewModel.errorMessage) { error in
            Alert(title: Text("Error"),
                  message: Text(error.message),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    // Format the start time for display.
    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: workoutStartDate)
    }
    
    // Delete performed exercise from the list.
    private func deleteExercise(at offsets: IndexSet) {
        performedExercises.remove(atOffsets: offsets)
    }
    
    // Reorder the performed exercises.
    private func moveExercise(from source: IndexSet, to destination: Int) {
        performedExercises.move(fromOffsets: source, toOffset: destination)
    }
    private func saveWorkout(){
        let workout = CreateWorkoutDto(description: description,
                                       startAtUtc:workoutStartDate,
                                       endAtUtc: Date(),
                                       notes: "TODO: Implement notes on UI",
                                       gymId: gym.id
        )
        Task{
            
                let _ =  await workoutViewModel.saveWorkout(workout)
                dismiss()
            
        }
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
