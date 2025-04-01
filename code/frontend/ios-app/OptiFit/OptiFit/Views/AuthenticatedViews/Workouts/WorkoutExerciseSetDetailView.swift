import SwiftUI

struct WorkoutExerciseSetDetailView: View {
    let workoutSets: [Components.Schemas.GetWorkoutSetDto]?

    var maxReps: Int {
        workoutSets?.compactMap { Int($0.reps ?? 0) }.max() ?? 0
    }

    var maxWeight: Double {
        workoutSets?.compactMap { $0.weight }.max() ?? 0.0
    }

    var body: some View {
        if let sets = workoutSets, !sets.isEmpty {
            Text("Set Details")
                .font(.headline)
                .padding(.horizontal)

            ForEach(sets.sorted(by: { ($0.order ?? 0) < ($1.order ?? 0) }), id: \.id) { set in
                WorkoutSetSummaryView(set: set, maxReps: maxReps, maxWeight: maxWeight)
                    .padding(.horizontal)
            }
        } else {
            Text("No sets available.")
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
    }
}

#Preview {
    WorkoutExerciseSetDetailView(workoutSets: [
        .init(
            id: UUID().uuidString,
            order: 1,
            reps: 10,
            weight: 20.5,
            workoutExerciseId: UUID().uuidString
        ),
        .init(
            id: UUID().uuidString,
            order: 2,
            reps: 15,
            weight: 30.5,
            workoutExerciseId: UUID().uuidString
        ),
        .init(
            id: UUID().uuidString,
            order: 3,
            reps: 25,
            weight: 35.5,
            workoutExerciseId: UUID().uuidString
        ),
    ])
}
