import SwiftUI

struct WorkoutTrackingView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var navigateToExerciseSheet: Bool = false

    @StateObject private var workoutViewModel = WorkoutViewModel()
    @EnvironmentObject private var currentWorkoutViewModel: CurrentWorkoutViewModel

    @State private var showCancelConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header: Workout category (motto)
            HStack {
                Text(currentWorkoutViewModel.selectedExerciseCategory?.i18NCode ?? "Unknown")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.primaryText))
                Spacer()
            }
            .padding(.horizontal)

            // Header: Gym name & city, Start time
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(Color(.primaryAccent))
                    Text("\(currentWorkoutViewModel.selectedGym?.name ?? "Unkown"), \(currentWorkoutViewModel.selectedGym?.city ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(Color(.primaryText))
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .foregroundColor(Color(.primaryAccent))
                    Text(formattedStartTime)
                        .font(.subheadline)
                        .foregroundColor(Color(.primaryText))
                }
            }
            .padding(.horizontal)

            // Timer (centered)
            HStack {
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "stopwatch")
                        .foregroundColor(Color(.primaryAccent))
                    Text(elapsedTimeString)
                        .font(.headline)
                        .foregroundColor(Color(.primaryAccent))
                }
                Spacer()
            }
            .padding(.vertical, 8)

            // Notes Field
            VStack(alignment: .leading, spacing: 4) {
                Text("Notes")
                    .font(.headline)
                    .foregroundColor(Color(.primaryText))
                TextEditor(text: $currentWorkoutViewModel.notes)
                    .frame(height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
            .padding(.horizontal)

            // Exercise List Section
            if currentWorkoutViewModel.workoutExercises.isEmpty {
                Text("No exercises added yet.")
                    .foregroundColor(.gray)
                    .padding(.vertical)
                    .padding(.horizontal)
            } else {
                List {
                    ForEach(currentWorkoutViewModel.workoutExercises.indices, id: \.self) { index in
                        NavigationLink(
                            destination: WorkoutExerciseEditView(
                                workoutExercise: $currentWorkoutViewModel.workoutExercises[index]
                            )
                        ) {
                            WorkoutExerciseListEntryView(
                                workoutExercise: $currentWorkoutViewModel.workoutExercises[index]
                            )
                        }
                    }
                    .onDelete(perform: currentWorkoutViewModel.removeExercise)
                    .onMove(perform: currentWorkoutViewModel.moveExercise)
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
                    onSave: { newExercise in
                        // Set order for the new exercise before appending.
                        var newExerciseWithOrder = newExercise
                        newExerciseWithOrder.order = Int32(currentWorkoutViewModel.workoutExercises.count + 1)
                        currentWorkoutViewModel.workoutExercises.append(newExerciseWithOrder)
                        navigateToExerciseSheet = false
                    },
                    order: currentWorkoutViewModel.workoutExercises.count + 1
                )
            }
        }
        //TODO: FIX Cancel Alert
        // Cancel confirmation alert.
        //        .alert(isPresented: $showCancelConfirmation) {
        //            Alert(
        //                title: Text("Cancel Workout"),
        //                message: Text("Are you sure you want to cancel this workout?"),
        //                primaryButton: .destructive(Text("Cancel Workout")) {
        //                    dismiss()
        //                },
        //                secondaryButton: .cancel()
        //            )
        //        }
        // Error alert.
        .alert(item: $workoutViewModel.errorMessage) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            currentWorkoutViewModel.startTimer()
        }
        .onDisappear {
            currentWorkoutViewModel.invalidateTimer()
        }
    }

    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: currentWorkoutViewModel.workoutStartDate)
    }

    var elapsedTimeString: String {
        let minutes = Int(currentWorkoutViewModel.elapsedTime) / 60
        let seconds = Int(currentWorkoutViewModel.elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func saveWorkout() {
        Task {
            if let savedWorkout = await currentWorkoutViewModel.saveWorkout() {
                workoutViewModel.appendWorkout(savedWorkout)
                dismiss()
            }
        }
    }

    // Only show the cancel confirmation; let the alert action handle dismissal.
    private func cancelWorkout() {
        showCancelConfirmation = true
        currentWorkoutViewModel.cancelWorkout()
    }
}
