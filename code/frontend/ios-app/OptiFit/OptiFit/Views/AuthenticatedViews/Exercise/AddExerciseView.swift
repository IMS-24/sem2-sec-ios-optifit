import SwiftUI
import PhotosUI

struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var exerciseViewModel: ExerciseViewModel
    
    @State private var name: String = ""
    @State private var selectedExerciseCategory: UUID?
    @State private var selectedMuscles: Set<GetMuscleDto> = []
    @State private var description: String = ""
    
    // Image selection state (currently not used)
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @StateObject private var muscleViewModel = MuscleViewModel()
    @StateObject private var exerciseCategoryViewModel = ExerciseCategoryViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                Form {
                    // Exercise Name Section
                    Section(header: Text("Exercise Name")
                        .font(.headline)) {
                            TextField("Exercise Name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    
                    // Exercise Type Section
                    Section(header: Text("Exercise Type")
                        .font(.headline)) {
                            if exerciseViewModel.isLoading {
                                ProgressView("Loading …")
                            } else if let error = exerciseViewModel.errorMessage {
                                Text(error.message)
                                    .foregroundColor(.red)
                            } else {
                                Picker(selection: $selectedExerciseCategory, label: Text("Select Type")) {
                                    ForEach(exerciseCategoryViewModel.exerciseCategories, id: \.id) { category in
                                        Text(category.i18NCode)
                                            .tag(category.id)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                    
                    // Muscles Section
                    Section(header: Text("Muscles")
                        .font(.headline)) {
                            if muscleViewModel.isLoading {
                                ProgressView("Loading …")
                            } else if let error = muscleViewModel.errorMessage {
                                Text(error.message)
                                    .foregroundColor(.red)
                            } else {
                                ForEach(muscleViewModel.muscles, id: \.id) { muscle in
                                    Toggle(isOn: Binding(
                                        get: { selectedMuscles.contains(muscle) },
                                        set: { isSelected in
                                            if isSelected {
                                                selectedMuscles.insert(muscle)
                                            } else {
                                                selectedMuscles.remove(muscle)
                                            }
                                        }
                                    )) {
                                        Text(muscle.i18NCode)
                                    }
                                }
                            }
                        }
                    
                    // Description Section
                    Section(header: Text("Description")
                        .font(.headline)) {
                            TextEditor(text: $description)
                                .frame(minHeight: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                                .padding(.top, 4)
                        }
                    
                    // Save Button Section
                    Section {
                        Button(action: saveExercise) {
                            Label("Save", systemImage: "checkmark.circle.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                // Hide the form’s default background so our custom background shows.
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Add Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task {
                    await muscleViewModel.searchMuscles()
                    await exerciseViewModel.searchExerciseCategories()
                    await exerciseCategoryViewModel.fetchCategories()
                }
            }
            .alert(item: $exerciseViewModel.errorMessage) { error in
                Alert(title: Text("Error"),
                      message: Text(error.message),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func saveExercise() {
        guard let selectedExerciseCategory = selectedExerciseCategory else {
            return
        }
        // Convert the image (if any) to JPEG data.
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        
        // Convert the selected muscles into an array of UUIDs, or nil if none selected.
        let muscleIds: [UUID]? = selectedMuscles.isEmpty ? nil : selectedMuscles.map { $0.id }
        
        let exercise = CreateExerciseDto(
            i18NCode: name,
            description: description,
            muscleIds: muscleIds,
            exerciseCategoryId: selectedExerciseCategory,
            imageData: imageData
        )
        
        Task {
            let _ = await exerciseViewModel.saveExercise(exerciseDto: exercise)
            dismiss()
        }
    }
}

#Preview {
    AddExerciseView()
}
