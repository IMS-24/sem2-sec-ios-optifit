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
    
    // Timer-related state for stopwatch functionality.
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var showCancelConfirmation = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header: Workout category (motto)
            HStack {
                Text(exerciseCategory.i18NCode)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryText"))
                Spacer()
            }
            .padding(.horizontal)
            
            // Header: Gym name & city, Start time
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(Color("PrimaryAccent"))
                    Text("\(gym.name), \(gym.city)")
                        .font(.subheadline)
                        .foregroundColor(Color("PrimaryText"))
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .foregroundColor(Color("PrimaryAccent"))
                    Text(formattedStartTime)
                        .font(.subheadline)
                        .foregroundColor(Color("PrimaryText"))
                }
            }
            .padding(.horizontal)
            
            // Timer (centered)
            HStack {
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "stopwatch")
                        .foregroundColor(Color("PrimaryAccent"))
                    Text(elapsedTimeString)
                        .font(.headline)
                        .foregroundColor(Color("PrimaryAccent"))
                }
                Spacer()
            }
            .padding(.vertical, 8)
            
            // Description Field
            VStack(alignment: .leading, spacing: 4) {
                Text("Description")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                TextEditor(text: $description)
                    .frame(height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
            .padding(.horizontal)
            
            // Exercise List Section
            if workoutExercises.isEmpty {
                Text("No exercises added yet.")
                    .foregroundColor(.gray)
                    .padding(.vertical)
                    .padding(.horizontal)
            } else {
                List {
                    // Use binding ForEach so the edit view can modify the exercise.
                    ForEach($workoutExercises) { $workoutExercise in
                        NavigationLink(destination: WorkoutExerciseEditView(workoutExercise: $workoutExercise)) {
                            WorkoutExerciseListEntryView(workoutExercise: $workoutExercise)
                        }
                    }
                    .onDelete(perform: deleteExercise)
                    .onMove(perform: moveExercise)
                }
                .listStyle(InsetGroupedListStyle())
            }
            
            Spacer()
            
            // Bottom Action Buttons: Save and Cancel
            HStack {
                Button(action: saveWorkout) {
                    Label("Save", systemImage: "checkmark")
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                
                Spacer()
                
                Button(action: cancelWorkout) {
                    Label("Cancel", systemImage: "xmark")
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .tint(.red)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .navigationTitle("Track Workout")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Plus button to add an exercise.
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigateToExerciseSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        // Sheet for selecting a new exercise.
        .sheet(isPresented: $navigateToExerciseSheet) {
            NavigationStack {
                ExerciseSelectionView(
                    exerciseCategoryId: exerciseCategory.id,
                    onExerciseSelected: { newExercise in
                        // Set order for the new exercise before appending.
                        var newExerciseWithOrder = newExercise
                        newExerciseWithOrder.order = workoutExercises.count + 1
                        workoutExercises.append(newExerciseWithOrder)
                        navigateToExerciseSheet = false
                    },
                    order: workoutExercises.count + 1
                )
            }
        }
        // Cancel confirmation alert.
        .alert(isPresented: $showCancelConfirmation) {
            Alert(
                title: Text("Cancel Workout"),
                message: Text("Are you sure you want to cancel this workout?"),
                primaryButton: .destructive(Text("Cancel Workout")) {
                    dismiss()
                },
                secondaryButton: .cancel()
            )
        }
        // Error alert.
        .alert(item: $workoutViewModel.errorMessage) { error in
            Alert(title: Text("Error"),
                  message: Text(error.message),
                  dismissButton: .default(Text("OK")))
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
        
    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: workoutStartDate)
    }
    
    var elapsedTimeString: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
        
    private func startTimer() {
        elapsedTime = Date().timeIntervalSince(workoutStartDate)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedTime = Date().timeIntervalSince(workoutStartDate)
        }
    }
        
    private func deleteExercise(at offsets: IndexSet) {
        workoutExercises.remove(atOffsets: offsets)
        updateExerciseOrders()
    }
    
    private func moveExercise(from source: IndexSet, to destination: Int) {
        workoutExercises.move(fromOffsets: source, toOffset: destination)
        updateExerciseOrders()
    }
    
    // Update each exercise's order property based on its current index.
    private func updateExerciseOrders() {
        for index in workoutExercises.indices {
            workoutExercises[index].order = index + 1
        }
    }
        
    private func saveWorkout() {
        let workout = CreateWorkoutDto(
            description: description,
            startAtUtc: workoutStartDate,
            endAtUtc: Date(),
            notes: "TODO: Implement notes on UI",
            gymId: gym.id,
            workoutExercises: workoutExercises
        )
        Task {
            let _ = await workoutViewModel.saveWorkout(workout)
            dismiss()
        }
    }
    private func cancelWorkout(){
         showCancelConfirmation = true
        dismiss()
    }
}

