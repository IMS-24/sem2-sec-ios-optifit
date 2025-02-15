import SwiftUI

struct ExerciseListEntryView: View {
    var exercise: Exercise

    var body: some View {
        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
            Text(exercise.i18NCode)
        }
    }
}

#Preview {
    ExerciseListEntryView(
            exercise: Exercise(
                    id: UUID(),
                    i18NCode: "ExerciseName",
                    description: "Some description",
                    muscleGroups: [
                        MuscleGroup(
                                id: UUID(),
                                i18NCode:
                                "MuscleGroup",
                                muscles: [
                                    Muscle(
                                            id: UUID(),
                                            i18NCode: "Muscle"
                                    )
                                ]
                        )
                    ],
                    muscles:
                    [Muscle(
                            id: UUID(),
                            i18NCode: "Muscle"
                    )
                    ],
                    exerciseType: "ExerciseType",
                    imageURL: nil
            )
    )
}
