import SwiftUI

struct ExerciseView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @State private var navigateToAddExercise = false
    // Holds the exercise selected for editing via swipe action.
    @State private var selectedExerciseForEdit: Components.Schemas.GetExerciseDto? = nil

    // Group exercises by category
    private var groupedExercises: [String: [Components.Schemas.GetExerciseDto]] {

        Dictionary(grouping: exerciseViewModel.exercises, by: { $0.exerciseCategory?.i18NCode! ?? "" })
    }

    var body: some View {
        NavigationStack {
            List {
                GroupedExercisesListView(groupedExercises: groupedExercises)
                //  Loading indicator for pagination.
                if exerciseViewModel.isLoadingMore {
                    ProgressView()
                        .onAppear {
                            Task {
                                await exerciseViewModel.loadMoreExercises()
                            }
                        }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        navigateToAddExercise = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // Navigation to the AddExerciseView.
            .navigationDestination(isPresented: $navigateToAddExercise) {
                AddExerciseView()
                    .environmentObject(exerciseViewModel)
            }
            // Navigation destination for editing an existing exercise.
            .navigationDestination(item: $selectedExerciseForEdit) { exercise in
                ExerciseDetailView(exercise: exercise, startEditing: true)
            }
            .refreshable {
                await exerciseViewModel.searchExercises()
            }
            .onAppear {
                Task {
                    await exerciseViewModel.searchExercises()
                }
            }
            .alert(item: $exerciseViewModel.errorMessage) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.message),
                    dismissButton: .default(Text("OK")))
            }
        }
    }

}
//
//#Preview {
//    ExerciseView()
//}
