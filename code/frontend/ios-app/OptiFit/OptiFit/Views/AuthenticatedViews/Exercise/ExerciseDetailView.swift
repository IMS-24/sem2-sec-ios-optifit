import SwiftUI

struct ExerciseDetailView: View {
    let exercise: GetExerciseDto
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var getExerciseStatisticsDto: GetExerciseStatisticsDto?
    @State private var isEditing = false
    @State private var editableName: String
    @State private var editableDescription: String
    @State private var editableCategory: String
    
    init(exercise: GetExerciseDto) {
        self.exercise = exercise
        _editableName = State(initialValue: exercise.i18NCode)
        _editableDescription = State(initialValue: exercise.description ?? "")
        _editableCategory = State(initialValue: exercise.exerciseCategory)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Existing content…
                Image(systemName: "figure.strengthtraining.traditional")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                
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
                
                Divider().padding(.horizontal)
                
                if let stats = getExerciseStatisticsDto {
                    ExerciseWorkoutSummaryList(statistics: stats)
                }
            }
            .padding(.vertical)
            .onAppear {
                Task {
                    let res = await exerciseViewModel.loadStatistics(exerciseId: exercise.id)
                    self.getExerciseStatisticsDto = res
                }
            }
        }
        .navigationTitle(editableName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
