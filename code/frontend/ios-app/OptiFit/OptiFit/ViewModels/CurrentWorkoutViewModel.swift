import Combine
import Foundation
import SwiftUI

@MainActor
class CurrentWorkoutViewModel: ObservableObject {
    @Published var workout: Components.Schemas.CreateWorkoutDto? = nil
    @Published var timer: Timer? = nil
    @Published var elapsedTime: TimeInterval = 0
    @Published var workoutStartDate: Date = Date()
    @Published var errorMessage: ErrorMessage?
    @Published var selectedGym: Components.Schemas.GetGymDto? = nil
    @Published var selectedExerciseCategory: Components.Schemas.GetExerciseCategoryDto? = nil
    @Published var notes: String = ""
    @Published var description: String = ""
    @Published var isLoading: Bool = false

    private let workoutService = WorkoutService()

    // Computed property to simplify accessing exercises.
    var workoutExercises: [Components.Schemas.CreateWorkoutExerciseDto] {
        get { workout?.workoutExercises ?? [] }
        set {
            if var currentWorkout = workout {
                currentWorkout.workoutExercises = newValue
                workout = currentWorkout
            }
        }
    }

    // Create a new workout if needed and start the timer.
    func startTimer() {
        if workout == nil {
            workout = Components.Schemas.CreateWorkoutDto(
                id: nil,
                description: description,
                startAtUtc: workoutStartDate,
                endAtUtc: nil,
                notes: notes,  // Use the view model's notes
                gymId: selectedGym?.id,
                workoutExercises: []
            )
        } else {
            workout?.startAtUtc = workoutStartDate
            workout?.gymId = selectedGym?.id
            // Ensure workout notes are in sync.
            workout?.notes = notes
            workout?.description = description
        }

        elapsedTime = Date().timeIntervalSince(workoutStartDate)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            Task { @MainActor in
                self.elapsedTime = Date().timeIntervalSince(self.workoutStartDate)
            }
        }
    }

    func invalidateTimer() {
        timer?.invalidate()
    }

    func setGym(_ gym: Components.Schemas.GetGymDto) {
        selectedGym = gym
        // If there's no workout yet, create one.
        if workout == nil {
            workout = Components.Schemas.CreateWorkoutDto(
                id: nil,
                description: description,
                startAtUtc: workoutStartDate,
                endAtUtc: nil,
                notes: notes,  // Use the view model's notes
                gymId: gym.id,
                workoutExercises: []
            )
        } else {
            workout?.notes = notes
            workout?.description = description
            workout?.startAtUtc = workoutStartDate
            workout?.gymId = gym.id
        }
    }

    func setExerciseCategory(_ category: Components.Schemas.GetExerciseCategoryDto?) {
        selectedExerciseCategory = category
    }

    func addExercise(_ exercise: Components.Schemas.CreateWorkoutExerciseDto) {
        guard var currentWorkout = workout else { return }
        var exercises = currentWorkout.workoutExercises ?? []
        exercises.append(exercise)
        currentWorkout.workoutExercises = exercises
        workout = currentWorkout
    }

    func removeExercise(at offsets: IndexSet) {
        guard var currentWorkout = workout else { return }
        var exercises = currentWorkout.workoutExercises ?? []
        exercises.remove(atOffsets: offsets)
        currentWorkout.workoutExercises = exercises
        workout = currentWorkout
        updateExerciseOrder()
    }

    func moveExercise(from source: IndexSet, to destination: Int) {
        guard var currentWorkout = workout else { return }
        var exercises = currentWorkout.workoutExercises ?? []
        exercises.move(fromOffsets: source, toOffset: destination)
        currentWorkout.workoutExercises = exercises
        workout = currentWorkout
        updateExerciseOrder()
    }

    private func updateExerciseOrder() {
        guard var currentWorkout = workout else { return }
        var exercises = currentWorkout.workoutExercises ?? []
        for index in exercises.indices {
            exercises[index].order = Int32(index) + 1
        }
        currentWorkout.workoutExercises = exercises
        workout = currentWorkout
    }

    func saveWorkout() async -> Components.Schemas.GetWorkoutDto? {
        guard var currentWorkout = workout else { return nil }
        do {
            currentWorkout.endAtUtc = Date()
            // Sync the view model's notes with the workout.
            currentWorkout.notes = notes
            currentWorkout.gymId = selectedGym?.id
            print("Save workout: \(currentWorkout)")
            isLoading = true
            errorMessage = nil

            let created = try await workoutService.postWorkout(currentWorkout)
            isLoading = false
            invalidateTimer()
            workout = nil
            elapsedTime = 0
            return created

        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        return nil
    }

    func cancelWorkout() {
        print("[Debug] - Cancel workout")
        if var currentWorkout = workout {
            currentWorkout.workoutExercises?.removeAll()
            workout = nil
        }
        elapsedTime = 0
        errorMessage = nil
    }
}
