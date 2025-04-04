import SwiftUI

struct ExerciseListEntryView: View {
    var exercise: Components.Schemas.GetExerciseDto

    var body: some View {
        Text(exercise.i18NCode!)
    }
}

#Preview {
    ExerciseListEntryView(
        exercise: Components.Schemas.GetExerciseDto(
            id: UUID().uuidString,
            i18NCode: "ExerciseName",
            description: "Some description",
            exerciseCategory: Components.Schemas.GetExerciseCategoryDto(id: UUID().uuidString, i18NCode: "CategoryName"),
            exerciseCategoryId: UUID().uuidString
        )
    )
}
