import SwiftUI

struct ExerciseListEntryView: View {
    var exercise: GetExerciseDto

    var body: some View {
        Text(exercise.i18NCode)
    }
}

#Preview {
    ExerciseListEntryView(
        exercise: GetExerciseDto(
            id: UUID(),
            i18NCode: "ExerciseName",
            description: "Some description",
            exerciseCategoryId: UUID(),
            exerciseCategory: ExerciseCategoryDto(id: UUID(), i18NCode: "CategoryName", exerciseIds: [])
        )
    )
}
