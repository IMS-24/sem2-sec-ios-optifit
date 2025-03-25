import Charts
import SwiftUI

struct ExerciseWorkoutSummaryCard: View {
    let workoutExercise: ExerciseWorkoutDto
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Workout on \(workoutExercise.workout.startAtUtc, formatter: dateFormatter)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            ExerciseWorkoutSummaryLineCharts(workoutExercise: workoutExercise)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
        .shadow(radius: 1)
        .padding(.horizontal)
    }
}

#Preview {
    ExerciseWorkoutSummaryCard(
        workoutExercise: ExerciseWorkoutDto(
            id: UUID(),
            order: 1,
            workout: GetWorkoutDto(
                id: UUID(),
                description: "Some Test Workout",
                startAtUtc: Date(),
                endAtUtc: Date(),
                notes: "Some Notes",
                gymId: UUID(),
                gym: GetGymDto(
                    address: "Daham",
                    zipCode: 8020,
                    id: UUID(),
                    name: "Home Gym",
                    city: "Graz"
                ),
                workoutExercises: [],
                workoutSummary: WorkoutSummary(
                    totalTime: 90,
                    totalSets: 15,
                    totalReps: 300,
                    totalWeight: 155.25,
                    totalExercises: 5
                )
            ),
            exerciseId: UUID(),
            workoutSets: [
                GetWorkoutSetDto(id: UUID(), order: 1, reps: 20, weight: 100, workoutExerciseId: UUID()),
                GetWorkoutSetDto(id: UUID(), order: 2, reps: 15, weight: 120, workoutExerciseId: UUID()),
                GetWorkoutSetDto(id: UUID(), order: 3, reps: 10, weight: 100, workoutExerciseId: UUID()),
            ],
            notes: "Some Notes"
        )
    )
}
