import SwiftUI

struct ExerciseListEntryView: View {
    var exercise: GetExerciseDto

    var body: some View {
        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
            Text(exercise.i18NCode)
        }
    }
}

#Preview {
    ExerciseListEntryView(
        exercise: GetExerciseDto(
                    id: UUID(),
                    i18NCode: "ExerciseName",
                    description: "Some description",
                    exerciseCategoryId: UUID(),
                    
//                    muscles:
//                    [Muscle(
//                            id: UUID(),
//                            i18NCode: "Muscle"
//                    )
//                    ],
                    exerciseCategory: "ExerciseCategory"
//                    imageURL: nil
            )
    )
}
