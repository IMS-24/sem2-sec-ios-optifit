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
//            List {
//                // Iterate over exercise groups by category.
//                ForEach(groupedExercises.keys.sorted(), id: \.self) { category in
//                    Section(header: Text(category).font(.headline)) {
//                        ForEach(groupedExercises[category] ?? []) { exercise in
//                            // Wrap the row content so we can add swipe actions.
//                            HStack {
//                                NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
//                                    ExerciseListEntryView(exercise: exercise)
//                                        .padding(.vertical, 5)
//                                }
//                            }
//                            .onAppear {
//                                // If this is the last exercise, load more.
//                                if exercise.id == exerciseViewModel.exercises.last?.id {
//                                    Task {
//                                        await exerciseViewModel.loadMoreExercises()
//                                    }
//                                }
//                            }
//                            .swipeActions {
//                                // Edit swipe action navigates to detail view in edit mode.
//                                Button {
//                                    selectedExerciseForEdit = exercise
//                                } label: {
//                                    Label("Edit", systemImage: "pencil")
//                                }
//                                // Delete swipe action.
//                                Button(role: .destructive) {
//                                    Task {
//                                        let success = await exerciseViewModel.deleteExercise(exerciseId: exercise.id)
//                                        if success {
//                                            // Optionally update UI, e.g., by removing the item locally.
//                                        }
//                                    }
//                                } label: {
//                                    Label("Delete", systemImage: "trash")
//                                }
//                            }
//                        }
//                    }
//                }

                // Loading indicator for pagination.
//                if exerciseViewModel.isLoadingMore {
//                    ProgressView()
//                        .onAppear {
//                            Task {
//                                await exerciseViewModel.loadMoreExercises()
//                            }
//                        }
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("Exercises")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        navigateToAddExercise = true
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            // Navigation to the AddExerciseView.
//            .navigationDestination(isPresented: $navigateToAddExercise) {
//                AddExerciseView()
//                    .environmentObject(exerciseViewModel)
//            }
//            // Navigation destination for editing an existing exercise.
//            .navigationDestination(item: $selectedExerciseForEdit) { exercise in
//                ExerciseDetailView(exercise: exercise, startEditing: true)
//            }
//            .refreshable {
//                await exerciseViewModel.searchExercises()
//            }
//            .onAppear {
//                Task {
//                    await exerciseViewModel.searchExercises()
//                }
//            }
//            .alert(item: $exerciseViewModel.errorMessage) { error in
//                Alert(
//                    title: Text("Error"),
//                    message: Text(error.message),
//                    dismissButton: .default(Text("OK")))
//            }
        }
    }
}

#Preview {
    ExerciseView()
}
