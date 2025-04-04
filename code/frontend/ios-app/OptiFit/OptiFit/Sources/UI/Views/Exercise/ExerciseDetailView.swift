import SwiftUI

extension Components.Schemas.GetExerciseDto {
    var mappedMuscles: [Components.Schemas.GetMuscleDto] {
        return muscleMapping?.compactMap { $0.muscleDto } ?? []
    }
}

struct ExerciseDetailView: View {
    let exercise: Components.Schemas.GetExerciseDto
    @EnvironmentObject private var exerciseViewModel: ExerciseViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var getExerciseStatisticsDto: Components.Schemas.GetExerciseStatisticsDto?

    init(exercise: Components.Schemas.GetExerciseDto) {
        self.exercise = exercise

    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Example image & styling
                Image(systemName: "figure.strengthtraining.traditional")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                // Name

                Text(exercise.i18NCode!)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Divider().padding(.horizontal)

                // Description
                if let description = exercise.description {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Description")
                            .font(.headline)
                            .padding(.horizontal)

                        Text(description)
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)

                    }
                }

                Divider().padding(.horizontal)
                ExerciseMuscleView(muscleMapping: exercise.muscleMapping)
                // Category
                if let category = exercise.exerciseCategory {
                    HStack {
                        Text("Type:")
                            .font(.headline)
                            .padding(.horizontal)

                        Text(category.i18NCode!.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                }

                Divider().padding(.horizontal)
                ExerciseMuscleGroupView(muscleMapping: exercise.muscleMapping)
                Divider().padding(.horizontal)

                // Display exercise statistics if available
                if let stats = getExerciseStatisticsDto {
                    ExerciseWorkoutSummaryView(statistics: stats)
                }
            }
            .padding(.vertical)
            .onAppear {
                Task {
                    let res = await exerciseViewModel.loadStatistics(exerciseId: UUID(uuidString: exercise.id!) ?? UUID())
                    self.getExerciseStatisticsDto = res
                }
            }
        }
        .navigationTitle(exercise.i18NCode!)
        .navigationBarTitleDisplayMode(.inline)
        //        .toolbar {
        //            ToolbarItem(placement: .navigationBarLeading) {
        //                Button(role: .destructive) {
        //                    Task {
        //                        var exerciseId: UUID {
        //                            do {
        //                                // Assuming exerciseCategory.id is of a type that can be cast to Decoder (which is unusual)
        //                                let id = try UUID(from: exercise.id as! Decoder)
        //                                return id
        //                            } catch {
        //                                return UUID()  // Fallback if conversion fails.
        //                            }
        //                        }
        //                        let success = await exerciseViewModel.deleteExercise(exerciseId: exerciseId)
        //                        if success {
        //                            dismiss()
        //                        } else {
        //                            // Handle deletion error as needed.
        //                        }
        //                    }
        //                } label: {
        //                    Image(systemName: "trash")
        //                }
        //            }
        //        }
    }
}

struct ExerciseDetailViewWrapper: View {

    let viewModel = ExerciseViewModel(exerciseService: MockExerciseService())
    private var groupedExercises: [String: [Components.Schemas.GetExerciseDto]] {

        Dictionary(grouping: viewModel.exercises, by: { $0.exerciseCategory?.i18NCode! ?? "" })
    }
    private var getFirstExercise: Components.Schemas.GetExerciseDto {
        viewModel.exercises.first
            ?? Components.Schemas.GetExerciseDto(
                id: UUID().uuidString,
                i18NCode: "Leg Extensions",
                description: "Some description of leg extension",
                exerciseCategory: Components.Schemas.GetExerciseCategoryDto(
                    id: UUID().uuidString,
                    i18NCode: "Chest"
                ),
                exerciseCategoryId: UUID().uuidString,
                muscleMapping: [
                    Components.Schemas.GetExerciseMuscleMappingDto(
                        id: UUID().uuidString,
                        exerciseId: UUID().uuidString,
                        muscleId: UUID().uuidString,
                        muscleDto: .init(),
                        intensity: 15)
                ]
            )
    }
    var body: some View {
        ExerciseDetailView(exercise: getFirstExercise)
            .environmentObject(viewModel)
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailViewWrapper()
    }
}
