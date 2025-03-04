import SwiftUI
import PhotosUI

struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var exerciseViewModel: ExerciseViewModel

    @State private var name: String = ""
    @State private var selectedExerciseCategory: UUID?
    @State private var selectedMuscles: Set<Muscle> = []

    @State private var description: String = ""
    
    // Image selection state
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @StateObject private var muscleViewModel = MuscleViewModel()
    @StateObject private var exerciseCategoryViewModel = ExerciseCategoryViewModel()
    
    
    var body: some View {
        NavigationView {
            Form {
                // Name Input
                Section(header: Text("Exercise Name")) {
                    TextField("Exercise Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Type Picker
                Section(header: Text("Exercise Type")) {
                    if exerciseViewModel.isLoading {
                        ProgressView("Loading ...")
                    } else if let error = exerciseViewModel.errorMessage {
                        Text(error.message)
                            .foregroundColor(.red)
                    } else {
                        Picker(selection:$selectedExerciseCategory, label: Text("Select Type")){
                            ForEach(exerciseCategoryViewModel.exerciseCategories, id:\.id){
                                category in Text(category.i18NCode).tag(category.id)
                            }
                        } .pickerStyle(SegmentedPickerStyle())
                    }
                }
            
                Section(header: Text("Muscles")) {
                    if muscleViewModel.isLoading {
                        ProgressView("Loading ...")
                    } else if let error = muscleViewModel.errorMessage {
                        Text(error.message)
                            .foregroundColor(.red)
                    } else {
                        ForEach(muscleViewModel.muscles, id: \.id) { muscle in
                            Toggle(isOn: Binding(
                                get: {
                                    selectedMuscles.contains(muscle)
                                },
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

                
                    //                // Image Picker Section with remove option
                    //                Section(header: Text("Exercise Image")) {
                    //                    PhotosPicker(
                    //                        selection: $selectedItem,
                    //                        matching: .images,
                    //                        photoLibrary: .shared()
                    //                    ) {
                    //                        HStack {
                    //                            Text("Select Image")
                    //                            Spacer()
                    //                            if let image = selectedImage {
                    //                                Image(uiImage: image)
                    //                                    .resizable()
                    //                                    .frame(width: 50, height: 50)
                    //                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    //                            }
                    //                        }
                    //                    }
                    //                    .onChange(of: selectedItem) { oldItem, newItem in
                    //                        Task {
                    //                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                    //                               let uiImage = UIImage(data: data) {
                    //                                selectedImage = uiImage
                    //                            }
                    //                        }
                    //                    }
                    //
                    //                    if selectedImage != nil {
                    //                        Button(action: {
                    //                            selectedImage = nil
                    //                            selectedItem = nil
                    //                        }) {
                    //                            Text("Remove Image")
                    //                                .foregroundColor(.red)
                    //                        }
                    //                    }
                    //                }
                    //
                                    // Description Input
                    Section(header: Text("Description")) {
                        TextEditor(text: $description)
                            .frame(minHeight: 100)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1))
                            .padding(.top, 4)
                    }
                    
                    // Save Button
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
                .navigationTitle("Add Exercise")
                .onAppear() {
                    Task{
                        await muscleViewModel.searchMuscles()
                        await exerciseViewModel.searchExerciseCategories()
                        await exerciseCategoryViewModel.fetchCategories()
                    }
                }
                .alert(item: $exerciseViewModel.errorMessage) { error in
                    Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                }
                
            }
        }
    
    
    private func saveExercise() {
        guard let selectedExerciseCategory = selectedExerciseCategory else { return }
        // Convert the image (if any) to JPEG data
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        
        // Convert the selected muscles into an array of UUIDs,
        // or nil if no muscles are selected.
        let muscleIds: [UUID]? = selectedMuscles.isEmpty ? nil : selectedMuscles.map { $0.id }
        
        let exercise = CreateExerciseDto(
            i18NCode: name,
            description: description,
            muscleIds: muscleIds,
            exerciseCategoryId: selectedExerciseCategory,
            imageData: imageData
        )
        
        Task {
            do{
                let _ = try await exerciseViewModel.saveExercise(exerciseDto: exercise)
                dismiss()}
            catch {
                
            }
        }
        //close add exercise view and switch back to overview
        
    }
}

#Preview {
    AddExerciseView()
}
