import SwiftUI

struct WorkoutStartView: View {
    @State private var selectedGym: UUID?
    @State private var selectedExerciseCategoryId: UUID?
    @State private var workoutDate = Date()
    @State private var navigateToWorkoutTrackingView = false

    @StateObject private var gymViewModel = GymViewModel()
    @StateObject private var exerciseCategoriesViewModel = ExerciseCategoryViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                // Date Picker Section
                DatePicker("Date", selection: $workoutDate, displayedComponents: [.date, .hourAndMinute])
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
                        Picker("Select Gym", selection: $selectedGym) {
                            ForEach(gymViewModel.gyms) { gym in
                                Text(gym.name)
                                    .tag(gym.id as UUID?)
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
                        Picker("Select Exercise Category", selection: $selectedExerciseCategoryId) {
                            ForEach(exerciseCategoriesViewModel.exerciseCategories) { category in
                                Text(category.i18NCode)
                                    .tag(category.id as UUID?)
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
                if let gym = gymViewModel.gyms.first(where: { $0.id == selectedGym }),
                    let exerciseCategory = exerciseCategoriesViewModel.exerciseCategories.first(where: { $0.id == selectedExerciseCategoryId })
                {
                    WorkoutTrackingView(
                        gym: gym,
                        exerciseCategory: exerciseCategory,
                        workoutStartDate: workoutDate)
                } else {
                    Text("Selection missing")
                }
            }
            .onAppear {
                Task {
                    await exerciseCategoriesViewModel.fetchCategories()
                    selectedExerciseCategoryId = exerciseCategoriesViewModel.exerciseCategories.first?.id
                    await gymViewModel.searchGyms()
                    selectedGym = gymViewModel.gyms.first?.id
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

#Preview {
    WorkoutStartView()
}
