
import SwiftUI

struct GroupedWorkoutView: View {
    let groupedWorkouts: [String: [Components.Schemas.GetWorkoutDto]]
    let groupBy: String
    var onLoadMore: () -> Void
    var body: some View {
        if let workouts = groupedWorkouts[groupBy] {
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
