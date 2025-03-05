//Done: 2025-03-05: 15:07

import SwiftUI

struct WorkoutTrackingView: View {
    @Environment(\.dismiss) private var dismiss
    let gym: GetGymDto
    let exerciseCategory: ExerciseCategoryDto
    let workoutStartDate: Date
    
    @State private var workoutExercises: [CreateWorkoutExerciseDto] = []
    @State private var navigateToExerciseSheet: Bool = false
    
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
            
            if workoutExercises.isEmpty {
                Text("No exercises performed yet.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(workoutExercises) { exercise in
                        Text(exercise.exerciseId.uuidString)//TODO: FIX
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
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Track Workout")
        .sheet(isPresented: $navigateToExerciseSheet) {
            NavigationStack {
                ExerciseSelectionView(
                    exerciseCategoryId: exerciseCategory.id,
                    onExerciseSelected: { workoutExercise in
                        workoutExercises.append(workoutExercise)
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
        workoutExercises.remove(atOffsets: offsets)
    }
    
    // Reorder the performed exercises.
    private func moveExercise(from source: IndexSet, to destination: Int) {
        workoutExercises.move(fromOffsets: source, toOffset: destination)
    }
    private func saveWorkout(){
        
        let createWorkoutExerciseDtos: [CreateWorkoutExerciseDto] = workoutExercises.map{
            return CreateWorkoutExerciseDto(order: 1,
                                            exerciseId: $0.exerciseId,
                                            notes: "TODO",
                                            workoutSets: $0.workoutSets.map{x in
                return CreateWorkoutSetDto(order: x.order, reps: x.reps!, weight: x.weight!)
                }
            )
        }
        let workout = CreateWorkoutDto(description: description,
                                       startAtUtc:workoutStartDate,
                                       endAtUtc: Date(),
                                       notes: "TODO: Implement notes on UI",
                                       gymId: gym.id,
                                       workoutExercises: createWorkoutExerciseDtos
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
        gym: GetGymDto(address: "Daham", zipCode: 8020, id: UUID(), name: "Downtown Gym", city: "Graz"),
        exerciseCategory: ExerciseCategoryDto(id: UUID(), i18NCode: "Strength", exerciseIds: []),
        workoutStartDate: Date()
    )
}
