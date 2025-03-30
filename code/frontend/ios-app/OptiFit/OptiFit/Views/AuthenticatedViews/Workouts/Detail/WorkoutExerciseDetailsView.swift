import SwiftUI

struct WorkoutExerciseDetailsView: View {
    let exercise: Components.Schemas.WorkoutExerciseDto

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header: Exercise title and description.
                VStack(alignment: .leading, spacing: 8) {
                    Text(exercise.exercise!.i18NCode!)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.primaryText))
                    if let desc = exercise.exercise?.description, !desc.isEmpty {
                        Text(desc)
                            .font(.body)
                            .foregroundColor(Color(.primaryText))
                    }
                }
                .padding(.horizontal)

                // Instead of one combined bar chart, show each set as its own graphical card.
                if let sets = exercise.workoutSets, !sets.isEmpty {
                    Text("Set Details")
                        .font(.headline)
                        .padding(.horizontal)
                    ForEach(sets.sorted(by: { $0.order! < $1.order! }), id: \.id) { set in
                        WorkoutSetSummaryView(set: set)
                            .padding(.horizontal)
                    }
                } else {
                    Text("No sets available.")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Exercise Details")
    }
}
#Preview {
    let legs = Components.Schemas.GetExerciseCategoryDto(id: UUID().uuidString, i18NCode: "Legs")
    WorkoutExerciseDetailsView(
        exercise: Components.Schemas.WorkoutExerciseDto(
            id: UUID().uuidString,
            order: 1,
            workoutId: UUID().uuidString,
            exercise: Components.Schemas.GetExerciseDto(
                id: UUID().uuidString,
                i18NCode: "Exercise Name",
                description: "Exercise Description",
                exerciseCategory: legs,
                exerciseCategoryId: legs.id
            ),
            workoutSets: [
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 5, reps: 100, weight: 150, workoutExerciseId: UUID().uuidString),
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 3, reps: 100, weight: 150, workoutExerciseId: UUID().uuidString),
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 1, reps: 10, weight: 20, workoutExerciseId: UUID().uuidString),
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 2, reps: 100, weight: 150, workoutExerciseId: UUID().uuidString),
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 4, reps: 100, weight: 150, workoutExerciseId: UUID().uuidString),
                Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 6, reps: 100, weight: 150, workoutExerciseId: UUID().uuidString),
            ],
            notes: "Some Notes"
        )
    )
}
