import SwiftUI

struct GroupedExercisesListView: View {
    let groupedExercises: [String: [Components.Schemas.GetExerciseDto]]

    var body: some View {
        GroupedListView(
            groupedItems: groupedExercises,
            onLoadMore: {
                print("[TODO - GroupedExercisesListView]: Implement load more")
            },
            content: { group, exercises, loadMore in
                GroupedExerciseView(
                    groupedExercises: groupedExercises,
                    group: group,
                    onLoadMore: loadMore
                )
            })
    }
}
