import SwiftUI

struct WorkoutTrackingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var activeAlert: ActiveAlert?

    @State private var navigateToExerciseSheet = false
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @EnvironmentObject private var currentWorkoutViewModel: CurrentWorkoutViewModel

    @State private var showCancelConfirmation = false

    // A computed binding to the workout exercises.
    private var workoutExercisesBinding: Binding<[Components.Schemas.CreateWorkoutExerciseDto]> {
        Binding<[Components.Schemas.CreateWorkoutExerciseDto]>(
            get: {
                // If no workout exists, return an empty array.
                currentWorkoutViewModel.workout?.workoutExercises ?? []
            },
            set: { newValue in
                if var workout = currentWorkoutViewModel.workout {
                    workout.workoutExercises = newValue
                    currentWorkoutViewModel.workout = workout
                }
            }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header: Show only if gym and exercise category are available.
            if let exerciseCategory = currentWorkoutViewModel.selectedExerciseCategory,
                let gym = currentWorkoutViewModel.selectedGym
            {
                WorkoutTrackingHeaderView(
                    exerciseCategory: exerciseCategory,
                    gym: gym,
                    workoutStartDate: currentWorkoutViewModel.workoutStartDate
                )
            }

            // Timer view.
            WorkoutTrackingTimerView(elapsedTime: currentWorkoutViewModel.elapsedTime)

            // Notes field.
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

            // Exercise list section using binding.
            WorkoutExercisesListView(
                workoutExercises: workoutExercisesBinding,
                onDelete: { indexSet in
                    currentWorkoutViewModel.removeExercise(at: indexSet)
                },
                onMove: { source, destination in
                    currentWorkoutViewModel.moveExercise(from: source, to: destination)
                }
            )

            Spacer()

            // Action buttons for save and cancel.
            WorkoutTrackingActionButtonView(
                onSave: saveWorkout,
                onCancel: { activeAlert = .cancel }
            )
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
                        var newExerciseWithOrder = newExercise
                        newExerciseWithOrder.order = Int32(workoutExercisesBinding.wrappedValue.count + 1)
                        currentWorkoutViewModel.addExercise(newExerciseWithOrder)
                        navigateToExerciseSheet = false
                    },
                    order: workoutExercisesBinding.wrappedValue.count + 1
                )
            }
        }
        .alert(item: $activeAlert) { alert in
            switch alert {
            case .cancel:
                return Alert(
                    title: Text("Cancel Workout"),
                    message: Text("Are you sure you want to cancel this workout?"),
                    primaryButton: .destructive(Text("Cancel Workout")) {
                        currentWorkoutViewModel.cancelWorkout()
                        dismiss()
                    },
                    secondaryButton: .cancel()
                )
            case .error(let message):
                return Alert(
                    title: Text("Error"),
                    message: Text(message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            currentWorkoutViewModel.startWorkout()
        }
        .onDisappear {
            currentWorkoutViewModel.stopWorkout()
        }
    }

    private func saveWorkout() {
        Task {
            if let savedWorkout = await currentWorkoutViewModel.saveWorkout() {
                workoutViewModel.appendWorkout(savedWorkout)
                dismiss()
            }
        }
    }
}
