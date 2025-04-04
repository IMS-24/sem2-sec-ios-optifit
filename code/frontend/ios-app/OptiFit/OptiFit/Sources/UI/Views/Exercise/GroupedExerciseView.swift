import SwiftUI

struct GroupedExerciseView: View {
    let groupedExercises: [String: [Components.Schemas.GetExerciseDto]]
    let group: String
    var onLoadMore: () -> Void
    var body: some View {
        ForEach(groupedExercises[group] ?? [], id: \.id) { exercise in

            NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                ExerciseListEntryView(exercise: exercise)
                    .padding(.vertical, 5)

            }
            .onAppear {
                onLoadMore()
            }
        }
    }
}

struct GroupedExerciseViewWrapper: View {

    let viewModel = ExerciseViewModel(exerciseService: MockExerciseService())
    private var groupedExercises: [String: [Components.Schemas.GetExerciseDto]] {

        Dictionary(grouping: viewModel.exercises, by: { $0.exerciseCategory?.i18NCode! ?? "" })
    }
    var body: some View {
        GroupedExerciseView(
            groupedExercises: groupedExercises,
            group: "legs",
            onLoadMore: { print("[DEBUG] Load more") }
        )
    }
}

struct GroupedExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedExerciseViewWrapper()

    }
}
