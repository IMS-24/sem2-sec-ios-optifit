import SwiftUI

struct WorkoutStartView: View {
    @State private var navigateToWorkoutTrackingView = false
    private var defaultExerciseCategory: Components.Schemas.GetExerciseCategoryDto? = nil
    @StateObject private var gymViewModel = GymViewModel()
    @StateObject private var exerciseCategoriesViewModel = ExerciseCategoryViewModel()
    @EnvironmentObject private var currentWorkoutViewModel: CurrentWorkoutViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                // Date Picker Section
                DatePicker("Date", selection: $currentWorkoutViewModel.workoutStartDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.compact)
                    .padding(.horizontal)

                // Gym Picker Section
                if gymViewModel.gyms.isEmpty {
                    ProgressView("Loading gyms…")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    HStack {
                        Text("Select Gym")
                            .font(.headline)
                        Spacer()
                        Picker("Select Gym", selection: $currentWorkoutViewModel.selectedGym) {
                            ForEach(gymViewModel.gyms, id: \.id) { gym in
                                Text(gym.name ?? "Unknown Gym")
                                    .tag(gym)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 5)
                }

                // Exercise Type Picker Section
                if exerciseCategoriesViewModel.exerciseCategories.isEmpty {
                    ProgressView("Loading exercise category…")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    HStack {
                        Text("Select Exercise Category")
                            .font(.headline)
                        Spacer()
                        Picker("Select Exercise Category", selection: $currentWorkoutViewModel.selectedExerciseCategory) {

                            Text("General Workout")
                                .tag(defaultExerciseCategory)

                            ForEach(exerciseCategoriesViewModel.exerciseCategories, id: \.id) { category in
                                Text(category.i18NCode ?? "Unknown")
                                    .tag(category)
                            }

                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 5)
                }

                // Start Workout Button
                Button("Start Workout") {
                    navigateToWorkoutTrackingView = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal)
                .accessibilityLabel("Start Workout")

                Spacer()
            }
            .navigationTitle("Start Workout")
            .padding()
            .navigationDestination(isPresented: $navigateToWorkoutTrackingView) {

                WorkoutTrackingView()

            }
            .onAppear {
                Task {
                    // First, fetch exercise categories and preselect the first category (if available)
                    await exerciseCategoriesViewModel.fetchCategories()
                    if let firstCategory = exerciseCategoriesViewModel.exerciseCategories.first {
                        currentWorkoutViewModel.setExerciseCategory(firstCategory)
                    }

                    // Then, fetch gyms and preselect the first gym (if available)
                    await gymViewModel.searchGyms()
                    if let firstGym = gymViewModel.gyms.first {
                        currentWorkoutViewModel.setGym(firstGym)
                    }
                    currentWorkoutViewModel.workoutStartDate = Date()
                }
            }
            .alert(item: $exerciseCategoriesViewModel.errorMessage) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.message),
                    dismissButton: .default(Text("OK")))
            }
        }
    }
}
