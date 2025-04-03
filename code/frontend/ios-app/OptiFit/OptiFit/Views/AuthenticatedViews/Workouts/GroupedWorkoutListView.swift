import SwiftUI

struct GroupedWorkoutListView: View {
    var groupedWorkouts: [String: [Components.Schemas.GetWorkoutDto]]

    private var sortedMonths: [String] {
        groupedWorkouts.keys.sorted(by: >)
    }

    var body: some View {
        ForEach(sortedMonths, id: \.self) { month in
            Section(
                header: Text(month)
                    .font(.headline)
                    .foregroundColor(Color(.primaryText))
            ) {
                GroupedWorkoutView(
                    groupedWorkouts: groupedWorkouts, groupBy: month,
                    onLoadMore: {
                        //TODO: Implement load more
    
                        print("[TODO - GroupedWorkoutListView]: Implement load more")
                    })

            }
        }
    }
}
