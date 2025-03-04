import SwiftUI

struct StartWorkoutView: View {
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
                        Picker("Select Gym", selection: Binding(
                            get: { selectedGym ?? gymViewModel.gyms.first!.id },
                            set: { selectedGym = $0 }
                        )) {
                            ForEach(gymViewModel.gyms) { gym in
                                Text(gym.name)
                                    .tag(gym.id)
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
                        Picker("Select Exercise Catgory", selection: Binding(
                            get: { selectedExerciseCategoryId ?? exerciseCategoriesViewModel.exerciseCategories.first!.id },
                            set: { selectedExerciseCategoryId = $0 }
                        )) {
                            ForEach(exerciseCategoriesViewModel.exerciseCategories) { type in
                                Text(type.i18NCode)
                                    .tag(type.id)
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
                   let exerciseCategory = exerciseCategoriesViewModel.exerciseCategories.first(where: { $0.id == selectedExerciseCategoryId }) {
                    WorkoutTrackingView(gym: gym,
                                        exerciseCategory: exerciseCategory,
                                        workoutStartDate: workoutDate)
                } else {
                    Text("Selection missing")
                }
            }
//            .refreshable {
//                gymViewModel.searchGyms()
//               await  exerciseTypeViewModel.fetchExerciseTypes()
//            }
//            .task {
//                gymViewModel.searchGyms()
//                exerciseTypeViewModel.fetchExerciseTypes()
//                if selectedGym == nil, let firstGym = gymViewModel.gyms.first {
//                    selectedGym = firstGym.id
//                }
//                if selectedExerciseType == nil, let firstType = exerciseTypeViewModel.exerciseTypes.first {
//                    selectedExerciseType = firstType.id
//                }
//            }
        }
    }
}

#Preview {
    StartWorkoutView()
}
