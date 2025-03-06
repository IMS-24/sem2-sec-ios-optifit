import SwiftUI

struct ExerciseDetailView: View {
    let exercise: GetExerciseDto
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // Editing state.
    @State private var isEditing = false
    // Editable copies of fields.
    @State private var editableName: String
    @State private var editableDescription: String
    @State private var editableCategory: String
    
    // Initialize editable states from the passed exercise.
    init(exercise: GetExerciseDto) {
        self.exercise = exercise
        _editableName = State(initialValue: exercise.i18NCode)
        _editableDescription = State(initialValue: exercise.description ?? "")
        _editableCategory = State(initialValue: exercise.exerciseCategory)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image Section with card-like style.
                Group {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Exercise Name: Editable if in edit mode.
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
                
                Divider()
                    .padding(.horizontal)
                
                // Description Section.
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
                
                Divider()
                    .padding(.horizontal)
                
                // Exercise Type Section.
                HStack {
                    Text("Type:")
                        .font(.headline)
                        .padding(.horizontal)
                    if isEditing {
                        TextField("Type", text: $editableCategory)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        Text(editableCategory.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                
                // Action Buttons.
                HStack(spacing: 16) {
//                    if isEditing {
//                        Button(action: {
//                            // Save edits.
//                            Task {
//                                // Replace with actual update API call.
//                                print("Saving changes: \(editableName), \(editableDescription), \(editableCategory)")
//                                isEditing = false
//                            }
//                        }) {
//                            Label("Save", systemImage: "checkmark.circle.fill")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
//                        
//                        Button(action: {
//                            // Cancel editing: revert changes.
//                            editableName = exercise.i18NCode
//                            editableDescription = exercise.description ?? ""
//                            editableCategory = exercise.exerciseCategory
//                            isEditing = false
//                        }) {
//                            Label("Cancel", systemImage: "xmark.circle.fill")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.gray)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
//                    } else {
//                        Button(action: {
//                            // Toggle edit mode.
//                            isEditing = true
//                        }) {
//                            Label("Edit", systemImage: "pencil")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
                        
                        Button(action: {
                            Task {
                             await exerciseViewModel.deleteExercise(exercise.id)
                                    // After deletion, switch back to the overview.
                                    dismiss()
                            
                            }
                        }) {
                            Label("Delete", systemImage: "trash.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
//                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            .padding(.vertical)
        }
        .navigationTitle(editableName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ExerciseDetailView(
        exercise: GetExerciseDto(
            id: UUID(),
            i18NCode: "ExerciseName",
            description: "ExerciseDescription",
            exerciseCategoryId: UUID(),
            exerciseCategory: "ExerciseCategory"
            //imageURL: nil
        )
    )
}
