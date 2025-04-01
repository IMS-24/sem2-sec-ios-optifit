import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Components.Schemas.GetExerciseDto
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @Environment(\.dismiss) private var dismiss

    @State private var getExerciseStatisticsDto: Components.Schemas.GetExerciseStatisticsDto?
    @State private var isEditing: Bool
    @State private var editableName: String
    @State private var editableDescription: String
    @State private var editableCategory: Components.Schemas.GetExerciseCategoryDto
    @State private var newCategoryId: UUID

    // Added startEditing parameter to allow launching in edit mode
    init(exercise: Components.Schemas.GetExerciseDto, startEditing: Bool = false) {
        self.exercise = exercise
        _editableName = State(initialValue: exercise.i18NCode!)
        _editableDescription = State(initialValue: exercise.description ?? "")
        _editableCategory = State(initialValue: exercise.exerciseCategory!)
        _isEditing = State(initialValue: startEditing)
        _newCategoryId = State(initialValue: UUID(uuidString: exercise.exerciseCategoryId!) ?? UUID())
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
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

                // Name editing vs. display
                if isEditing {
                    TextField("Exercise Name", text: $editableName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                } else {
                    Text(editableName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                }

                Divider().padding(.horizontal)

                // Description editing vs. display
                VStack(alignment: .leading, spacing: 4) {
                    Text("Description")
                        .font(.headline)
                        .padding(.horizontal)
                    if isEditing {
                        TextEditor(text: $editableDescription)
                            .frame(minHeight: 100)
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                    } else {
                        Text(editableDescription.isEmpty ? "No description available." : editableDescription)
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                }

                Divider().padding(.horizontal)

                // Category editing vs. display
                HStack {
                    Text("Type:")
                        .font(.headline)
                        .padding(.horizontal)
                    if isEditing {
                        //                        TextField("Type", text: $editableCategory)
                        //                            .font(.subheadline)
                        //                            .foregroundColor(.gray)
                        //                            .padding(.horizontal)
                    } else {
                        Text(editableCategory.i18NCode!.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                }

                Divider().padding(.horizontal)

                // Display exercise statistics if available
                if let stats = getExerciseStatisticsDto {
                    ExerciseWorkoutSummaryList(statistics: stats)
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
        .navigationTitle(editableName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isEditing {
                // When editing, show Cancel and Save buttons.
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {

                        // Reset changes and exit edit mode.
                        editableName = exercise.i18NCode!
                        editableDescription = exercise.description ?? ""
                        editableCategory = exercise.exerciseCategory!
                        isEditing = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            // Create an updated exercise object
                            let updatedExercise = Components.Schemas.UpdateExerciseDto(
                                //                                id: exercise.id,
                                i18NCode: editableName,
                                description: editableDescription,
                                exerciseCategoryId: newCategoryId.uuidString
                                    //                                exerciseCategory: editableCategory
                            )
                            // Call view model update; assume it returns a Bool indicating success.
                            let success = await exerciseViewModel.updateExercise(
                                id: UUID(uuidString: exercise.id!) ?? UUID(),
                                exerciseDto: updatedExercise)
                            if success {
                                isEditing = false
                            } else {
                                // Handle update error as needed.
                            }
                        }
                    }
                }
            } else {
                // When not editing, show an Edit button and a Delete button.
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        isEditing = true
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .destructive) {
                        Task {
                            var exerciseId: UUID {
                                do {
                                    // Assuming exerciseCategory.id is of a type that can be cast to Decoder (which is unusual)
                                    let id = try UUID(from: exercise.id as! Decoder)
                                    return id
                                } catch {
                                    return UUID()  // Fallback if conversion fails.
                                }
                            }
                            let success = await exerciseViewModel.deleteExercise(exerciseId: exerciseId)
                            if success {
                                dismiss()
                            } else {
                                // Handle deletion error as needed.
                            }
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
    }
}
