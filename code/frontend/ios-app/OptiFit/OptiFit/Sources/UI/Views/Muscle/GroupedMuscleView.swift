import SwiftUI

struct GroupedMuscleView: View {
    let groupedMuscles: [String: [Components.Schemas.GetMuscleDto]]
    let group: String
    var onLoadMore: () -> Void
    var body: some View {
        ForEach(groupedMuscles[group] ?? [], id: \.id) { muscle in

            NavigationLink(destination: MuscleDetailView(muscle: muscle)) {
                Text(muscle.i18NCode!)
                //                ExerciseListEntryView(exercise: muscle)
                //                    .padding(.vertical, 5)
                //
            }
            .onAppear {
                onLoadMore()
            }
        }
    }
}
