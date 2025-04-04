import SwiftUI

struct WorkoutExerciseDetailsView: View {
    let workoutExercise: Components.Schemas.WorkoutExerciseDto

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                WorkoutExerciseSetDetailView(workoutSets: workoutExercise.workoutSets)
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle(workoutExercise.exercise!.i18NCode!)
    }
}
#Preview {
    let legs = Components.Schemas.GetExerciseCategoryDto(id: UUID().uuidString, i18NCode: "Legs")
    WorkoutExerciseDetailsView(
        workoutExercise: Components.Schemas.WorkoutExerciseDto(
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
