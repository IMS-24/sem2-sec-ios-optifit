import PhotosUI
import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var exerciseViewModel: ExerciseViewModel

    @State private var name: String = ""
    @State private var selectedExerciseCategory: Components.Schemas.GetExerciseCategoryDto?
    @State private var selectedMuscles: Set<Components.Schemas.GetMuscleDto> = []
    @State private var description: String = ""

    // Image selection state (currently not used)
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @EnvironmentObject private var muscleViewModel: MuscleViewModel
    @EnvironmentObject private var exerciseCategoryViewModel: ExerciseCategoryViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                Form {
                    ExerciseNameSection(name: $name)
                    ExerciseCategorySection(selectedExerciseCategory: $selectedExerciseCategory)
                    MusclesSection(selectedMuscles: $selectedMuscles)
                    DescriptionSection(description: $description)
                    SaveButtonSection(action: saveExercise)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Add Exercise")
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
//        let muscleIds: [UUID]? = selectedMuscles.isEmpty ? nil : selectedMuscles.map { $0.id } as! [UUID]
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
        let muscleMappings = selectedMuscles.map { muscle in
            return Components.Schemas.CreateExerciseMuscleMappingDto(muscleId: muscle.id)
        }
        let exercise = Components.Schemas.CreateExerciseDto(
            i18NCode: name,
            description: description,
            exerciseCategoryId: selectedExerciseCategory.id, createExerciseMuscleMappingDtos: muscleMappings
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



struct AddExerciseViewWrapper: View {
    
    let viewModel = ExerciseViewModel(exerciseService: MockExerciseService())
    let muscleViewModel: MuscleViewModel = .init(muscleService: MockMuscleService())
    let exerciseCategoryViewModel: ExerciseCategoryViewModel = .init(exerciseService: MockExerciseService())
    var body: some View {
        AddExerciseView()
            .environmentObject(viewModel)
            .environmentObject(muscleViewModel)
            .environmentObject(exerciseCategoryViewModel)
    }
}
struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseViewWrapper()
    }
}

