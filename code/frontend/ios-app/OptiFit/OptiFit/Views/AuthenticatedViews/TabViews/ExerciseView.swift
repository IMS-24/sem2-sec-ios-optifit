import SwiftUI

struct ExerciseView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @EnvironmentObject private var authViewModel : AuthViewModel
    @State private var navigateToAddExercise = false
    
    // Group exercises by category
    private var groupedExercises: [String: [GetExerciseDto]] {
        Dictionary(grouping: exerciseViewModel.exercises, by: { $0.exerciseCategory })
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Iterate over each exercise category group (sorted alphabetically)
                ForEach(groupedExercises.keys.sorted(), id: \.self) { category in
                    Section(header: Text(category).font(.headline)) {
                        ForEach(groupedExercises[category] ?? []) { exercise in
                            NavigationLink {
                                ExerciseDetailView(exercise: exercise)
                            } label: {
                                ExerciseListEntryView(exercise: exercise)
                                    .padding(.vertical, 5)
                            }
                            .onAppear {
                                // If this is the last exercise, load more.
                                if exercise.id == exerciseViewModel.exercises.last?.id {
                                    Task {
                                        await exerciseViewModel.loadMoreExercises(token:authViewModel.accessToken!)
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Loading indicator at the bottom.
                if exerciseViewModel.isLoadingMore {
                    ProgressView()
                        .onAppear {
                            Task {
                                await exerciseViewModel.loadMoreExercises(token:authViewModel.accessToken!)
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
            .navigationDestination(isPresented: $navigateToAddExercise) {
                AddExerciseView()
                    .environmentObject(exerciseViewModel)
            }
            .refreshable {
                await exerciseViewModel.searchExercises(token:authViewModel.accessToken!)
            }
            .onAppear {
                Task {
                    await exerciseViewModel.searchExercises(token:authViewModel.accessToken!)
                }
            }
            .alert(item: $exerciseViewModel.errorMessage) { error in
                Alert(title: Text("Error"),
                      message: Text(error.message),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    ExerciseView()
}
