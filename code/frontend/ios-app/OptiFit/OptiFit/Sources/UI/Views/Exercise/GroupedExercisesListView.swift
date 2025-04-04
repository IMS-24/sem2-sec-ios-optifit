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

struct GroupedExercisesListViewWrapper: View {
    
    let viewModel = ExerciseViewModel(exerciseService: MockExerciseService())
    private var groupedExercises: [String: [Components.Schemas.GetExerciseDto]] {
        
        Dictionary(grouping: viewModel.exercises, by: { $0.exerciseCategory?.i18NCode! ?? "" })
    }
    var body: some View {
        GroupedExercisesListView(groupedExercises: groupedExercises)
    }
}
struct GroupedExercisesListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedExercisesListViewWrapper()
    }
}
