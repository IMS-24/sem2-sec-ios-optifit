import SwiftUI

struct ExerciseView: View {
    @EnvironmentObject private var exerciseViewModel: ExerciseViewModel
    @State private var navigateToAddExercise = false
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
            .refreshable {
                await exerciseViewModel.searchExercises()
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



struct ExerciseViewWrapper: View {
    
    let viewModel = ExerciseViewModel(exerciseService: MockExerciseService())
    
    var body: some View {
        ExerciseView()
            .environmentObject(viewModel)
    }
}
struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseViewWrapper()
    }
}

