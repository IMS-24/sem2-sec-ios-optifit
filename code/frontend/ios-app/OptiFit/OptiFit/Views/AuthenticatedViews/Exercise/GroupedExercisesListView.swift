import SwiftUI

struct GroupedExercisesListView: View {
    var groupedExercises: [String: [Components.Schemas.GetExerciseDto]]

    init(groupedExercises: [String: [Components.Schemas.GetExerciseDto]]) {
        self.groupedExercises = groupedExercises
    }

    private var sortedGroups: [String] {
        groupedExercises.keys.sorted(by: >)
    }
    var body: some View {
        ForEach(sortedGroups, id: \.self) { group in
            Section(
                header: Text(group)
                    .font(.headline)
                    .foregroundColor(Color(.primaryText))
            ) {
                GroupedExerciseView(
                    groupedExercises: groupedExercises, group: group,
                    onLoadMore: {
                        //TODO: Implement load more
                        print("[TODO - GroupedExercisesListView]: Implement load more")
                    }

                )
            }
        }
    }
}
