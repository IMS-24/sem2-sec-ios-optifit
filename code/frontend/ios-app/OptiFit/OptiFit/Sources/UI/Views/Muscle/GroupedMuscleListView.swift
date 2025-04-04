import SwiftUI

struct GroupedMuscleListView: View{
    let groupedMuscles: [String: [Components.Schemas.GetMuscleDto]]
    var body: some View{
        GroupedListView(groupedItems: groupedMuscles,
                        onLoadMore: {
            print("[TODO - GroupedMuscleListView]: Implement load more")
        },
                        content: { group, exercises, loadMore in
            GroupedMuscleView(
                groupedMuscles: groupedMuscles,
                group: group,
                onLoadMore: loadMore
            )
        })
    }
}
