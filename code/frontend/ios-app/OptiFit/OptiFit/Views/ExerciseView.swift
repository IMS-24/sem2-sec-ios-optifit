import SwiftUI

struct ExerciseView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @State private var searchText: String = ""
    @State private var isAddExercisePresented: Bool = false

    // Group exercises by type using a computed property with an explicit type
    var groupedExercises: [String: [GetExerciseDto]] {
        let grouped: [String: [GetExerciseDto]] = Dictionary(grouping: exerciseViewModel.exercises, by: { exercise in
            exercise.exerciseCategory
        })
        return grouped
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: { isAddExercisePresented.toggle() }) {
                        Label("Add Exercise", systemImage: "plus.circle.fill")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                    }
                }

                SearchBar(text: $searchText)

                List {
                    ForEach(groupedExercises.keys.sorted(), id: \.self) { group in
                        Section(header: Text(group)) {
                            if let exercisesForGroup = groupedExercises[group] {
                                ForEach(exercisesForGroup, id: \.id) { exercise in
                                    ExerciseListEntryView(exercise: exercise)
                                            .onAppear {
                                                // Compare using the exercise id instead of the entire struct
                                                if exercise.id == exerciseViewModel.exercises.last?.id {
                                                    Task {
                                                        await exerciseViewModel.loadMoreExercises()
                                                    }
                                                }
                                            }
                                }
                            }
                        }
                    }

                    // Optionally, a loading indicator at the bottom
                    if !exerciseViewModel.exercises.isEmpty {
                        ProgressView()
                                .onAppear {
                                    Task {
                                        await exerciseViewModel.loadMoreExercises()
                                    }
                                }
                    }
                }
                        .listStyle(InsetGroupedListStyle())
            }
                    .navigationTitle("Exercises")
                    .onAppear {
                        Task {
                            await exerciseViewModel.searchExercises()
                        }
                    }
                    .alert(item: $exerciseViewModel.errorMessage) { error in
                        Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                    }
                    .sheet(isPresented: $isAddExercisePresented) {
                        AddExerciseView()
                    }
        }
    }
}

#Preview {
    ExerciseView()
}
