
import SwiftUI

struct GroupedWorkoutView: View {
    let groupedWorkouts: [String: [Components.Schemas.GetWorkoutDto]]
    let group: String
    var onLoadMore: () -> Void
    var body: some View {
        if let workouts = groupedWorkouts[group] {
            ForEach(workouts, id: \.id) { workout in
                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                    WorkoutListEntryView(workout: workout)
                }
                .onAppear {
                    onLoadMore()
                }
            }
        }
    }
}
