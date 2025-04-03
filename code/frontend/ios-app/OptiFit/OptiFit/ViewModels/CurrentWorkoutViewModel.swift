import Combine
import Foundation
import SwiftUI

@MainActor
class CurrentWorkoutViewModel: ObservableObject {
    @Published var workoutExercises: [Components.Schemas.CreateWorkoutExerciseDto] = []
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

    func startTimer() {
        self.elapsedTime = Date().timeIntervalSince(self.workoutStartDate)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            Task { @MainActor in
                self.elapsedTime = Date().timeIntervalSince(self.workoutStartDate)
            }
        }
    }

    func invalidateTimer() {
        self.timer?.invalidate()
    }
    func setGym(_ gym: Components.Schemas.GetGymDto) {
        self.selectedGym = gym
    }
    func setExerciseCategory(_ category: Components.Schemas.GetExerciseCategoryDto?) {
        self.selectedExerciseCategory = category
    }

    func addExercise(_ exercise: Components.Schemas.CreateWorkoutExerciseDto) {
        self.workoutExercises.append(exercise)
    }

    func removeExercise(at offset: IndexSet) {
        self.workoutExercises.remove(atOffsets: offset)
        updateExerciseOrder()
    }

    func moveExercise(from source: IndexSet, to destination: Int) {
        self.workoutExercises.move(fromOffsets: source, toOffset: destination)
        updateExerciseOrder()
    }

    private func updateExerciseOrder() {
        for index in self.workoutExercises.indices {
            self.workoutExercises[index].order = Int32(index) + 1
        }
    }
    func saveWorkout() async -> Components.Schemas.GetWorkoutDto? {
        do {
            let workout = Components.Schemas.CreateWorkoutDto(
                description: description,
                startAtUtc: workoutStartDate,
                endAtUtc: Date(),
                notes: notes,
                gymId: selectedGym!.id,
                workoutExercises: workoutExercises
            )
            print("Save workout: \(workout)")
            isLoading = true
            errorMessage = nil

            let created = try await workoutService.postWorkout(workout)
            isLoading = false
            return created

        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        return nil
    }

    func cancelWorkout() {
        workoutExercises.removeAll()
        elapsedTime = 0
        errorMessage = nil

    }

}
