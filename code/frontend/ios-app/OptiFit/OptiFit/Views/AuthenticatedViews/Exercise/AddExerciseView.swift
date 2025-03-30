import PhotosUI
import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var exerciseViewModel: ExerciseViewModel
    
    @State private var name: String = ""
    @State private var selectedExerciseCategory: UUID?
    @State private var selectedMuscles: Set<Components.Schemas.GetMuscleDto> = []
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
                    ExerciseNameSection(name: $name)
                    ExerciseTypeSection(selectedExerciseCategory: $selectedExerciseCategory,
                                        exerciseViewModel: exerciseViewModel,
                                        exerciseCategoryViewModel: exerciseCategoryViewModel)
                    MusclesSection(selectedMuscles: $selectedMuscles,
                                   muscleViewModel: muscleViewModel)
                    DescriptionSection(description: $description)
                    SaveButtonSection(action: saveExercise)
                }
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
                Alert(
                    title: Text("Error"),
                    message: Text(error.message),
                    dismissButton: .default(Text("OK"))
                )
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
        let muscleIds: [UUID]? = selectedMuscles.isEmpty ? nil : selectedMuscles.map { $0.id } as! [UUID]
        /*
         public struct CreateExerciseDto: Codable, Hashable, Sendable {
         /// - Remark: Generated from `#/components/schemas/CreateExerciseDto/i18NCode`.
         public var i18NCode: Swift.String?
         /// - Remark: Generated from `#/components/schemas/CreateExerciseDto/description`.
         public var description: Swift.String?
         /// - Remark: Generated from `#/components/schemas/CreateExerciseDto/exerciseCategoryId`.
         public var exerciseCategoryId: Swift.String?
         /// - Remark: Generated from `#/components/schemas/CreateExerciseDto/createExerciseMuscleMappingDtos`.
         public var createExerciseMuscleMappingDtos: [Components.Schemas.CreateExerciseMuscleMappingDto]?
         /// Creates a new `CreateExerciseDto`.
         */
        let exercise = Components.Schemas.CreateExerciseDto(
            i18NCode: name,
            description: description,
//            muscleIds: muscleIds,
            exerciseCategoryId: selectedExerciseCategory.uuidString
//            imageData: imageData
        )
        
        Task {
            let _ = await exerciseViewModel.saveExercise(exerciseDto: exercise)
            dismiss()
        }
    }
}

// MARK: - Subviews

struct ExerciseNameSection: View {
    @Binding var name: String
    
    var body: some View {
        Section(header: Text("Exercise Name").font(.headline)) {
            TextField("Exercise Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct ExerciseTypeSection: View {
    @Binding var selectedExerciseCategory: UUID?
    var exerciseViewModel: ExerciseViewModel
    var exerciseCategoryViewModel: ExerciseCategoryViewModel
    
    var body: some View {
        Section(header: Text("Exercise Type").font(.headline)) {
            if exerciseViewModel.isLoading {
                ProgressView("Loading …")
            } else if let error = exerciseViewModel.errorMessage {
                Text(error.message)
                    .foregroundColor(.red)
            } else {
                Picker(selection: $selectedExerciseCategory, label: Text("Select Type")) {
                    ForEach(exerciseCategoryViewModel.exerciseCategories, id: \.id) { category in
                        Text(category.i18NCode!)
                            .tag(category.id)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct MusclesSection: View {
    @Binding var selectedMuscles: Set<Components.Schemas.GetMuscleDto>
    var muscleViewModel: MuscleViewModel
    
    var body: some View {
        Section(header: Text("Muscles").font(.headline)) {
            if muscleViewModel.isLoading {
                ProgressView("Loading …")
            } else if let error = muscleViewModel.errorMessage {
                Text(error.message)
                    .foregroundColor(.red)
            } else {
                ForEach(muscleViewModel.muscles, id: \.id) { muscle in
                    Toggle(
                        isOn: Binding(
                            get: { selectedMuscles.contains(muscle) },
                            set: { isSelected in
                                if isSelected {
                                    selectedMuscles.insert(muscle)
                                } else {
                                    selectedMuscles.remove(muscle)
                                }
                            }
                        )
                    ) {
                        Text(muscle.i18NCode!)
                    }
                }
            }
        }
    }
}

struct DescriptionSection: View {
    @Binding var description: String
    
    var body: some View {
        Section(header: Text("Description").font(.headline)) {
            TextEditor(text: $description)
                .frame(minHeight: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(.top, 4)
        }
    }
}

struct SaveButtonSection: View {
    var action: () -> Void
    
    var body: some View {
        Section {
            Button(action: action) {
                Label("Save", systemImage: "checkmark.circle.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    AddExerciseView()
}
