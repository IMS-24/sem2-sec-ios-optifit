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
