import SwiftUI

struct GroupedWorkoutListView: View {
    let groupedWorkouts: [String: [Components.Schemas.GetWorkoutDto]]

    var body: some View {
        GroupedListView(
            groupedItems: groupedWorkouts,
            onLoadMore: {
                print("[TODO - GroupedWorkoutListView]: Implement load more")

            },
            content: { group, exercises, loadMore in
                GroupedWorkoutView(
                    groupedWorkouts: groupedWorkouts,
                    group: group,
                    onLoadMore: loadMore
                )
            })
    }
}
