import Charts
import SwiftUI

struct ExerciseWorkoutSummaryCard: View {
    let workoutExercise: Components.Schemas.ExerciseWorkoutDto
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Workout on \((workoutExercise.workout?.startAtUtc!)!, formatter: dateFormatter)")
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
        workoutExercise: Components.Schemas.ExerciseWorkoutDto(
            id: UUID().uuidString,
            order: 1,
            workout: Components.Schemas.GetWorkoutDto(
                id: UUID().uuidString,
                description: "Some Test Workout",
                startAtUtc: Date(),
                endAtUtc: Date(),
                notes: "Some Notes",
                gymId: UUID().uuidString,
                gym: Components.Schemas.GetGymDto(
                    id: UUID().uuidString,
                    name: "Home Gym",
                    address: "Daham",
                    city: "Graz",
                    zipCode: 8020
                ),
                workoutExercises: [],
                workoutSummary: Components.Schemas.WorkoutSummary(
                    totalTime: 90,
                    totalSets: 15,
                    totalReps: 300,
                    totalWeight: 155.25,
                    totalExercises: 5
                )
            ),
            exerciseId: UUID().uuidString,
            workoutSets: [
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 1, reps: 20, weight: 100, workoutExerciseId: UUID().uuidString),
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 2, reps: 15, weight: 120, workoutExerciseId: UUID().uuidString),
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 3, reps: 10, weight: 100, workoutExerciseId: UUID().uuidString),
            ],
            notes: "Some Notes"
        )
    )
}
