import SwiftUI

struct ExerciseSelectionView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @EnvironmentObject private var currentWorkoutViewModel: CurrentWorkoutViewModel
    
    let onSave: (Components.Schemas.CreateWorkoutExerciseDto) -> Void
    let order: Int
    
    private var groupedExercises: [String: [Components.Schemas.GetExerciseDto]] {
        Dictionary(grouping: exerciseViewModel.exercises, by: { $0.exerciseCategory?.i18NCode ?? "" })
    }
    private var sortedGroups: [String] {
        groupedExercises.keys.sorted(by: >)
    }
    
    var body: some View {
        List {
            ForEach(sortedGroups, id: \.self) { group in
                Section(
                    header: Text(group)
                        .font(.headline)
                        .foregroundColor(Color(.primaryText))
                ) {
                    if let exercises = groupedExercises[group] {
                        ForEach(exercises, id: \.self) { exercise in
                            NavigationLink(
                                destination: LazyView {
                                    ExerciseSetDetailView(
                                        selectedExercise: exercise,
                                        order: order,
                                        onSave: onSave
                                    )
                                }
                            ) {
                                Text(exercise.i18NCode ?? "Unknown")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Select Exercise")
        .onAppear {
            if let selectedExerciseCategoryId = currentWorkoutViewModel.selectedExerciseCategory?.id {
                let updatedSearchModel = Components.Schemas.SearchExerciseDto(exerciseCategoryId: selectedExerciseCategoryId)
                exerciseViewModel.updateSearchModel(updatedSearchModel)
            } else {
                Task {
                    await exerciseViewModel.searchExercises()
                }
            }
        }
    }
}
