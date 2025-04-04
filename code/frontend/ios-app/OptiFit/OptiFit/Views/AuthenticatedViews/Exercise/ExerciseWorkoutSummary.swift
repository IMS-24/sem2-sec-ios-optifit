import SwiftUI

struct ExerciseWorkoutSummary: View {
    let exerciseWorkoutsDto: [Components.Schemas.ExerciseWorkoutDto]?
    var body: some View {
        TabView {
            ForEach(exerciseWorkoutsDto ?? [], id: \.self) { workoutExercise in
                ExerciseWorkoutSummaryCard(workoutExercise: workoutExercise)
                    .padding(.vertical)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .padding()
    }
}
