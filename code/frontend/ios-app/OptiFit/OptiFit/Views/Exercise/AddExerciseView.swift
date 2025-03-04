import SwiftUI
import PhotosUI

struct AddExerciseView: View {
    @State private var name: String = ""
    @State private var selectedExerciseCategory: UUID?
    @State private var selectedMuscles: Set<UUID> = []
    @State private var description: String = ""
    
    // Image selection state
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
//    @StateObject private var muscleGroupViewModel = MuscleGroupViewModel()
    @StateObject private var muscleViewModel = MuscleViewModel()
    @StateObject private var exerciseViewModel = ExerciseViewModel()
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
                //Multi-Select Muscles
//                Section(header: Text("Muscles")){
//                    if muscleViewModel.isLoading{
//                        ProgressView("Loading ...")
//                    } else if let error = muscleViewModel.errorMessage {
//                        Text(error.message)
//                            .foregroundColor(.red)
//                    } else {
//                        Picker("Select Muscles", selection: Binding(
//                            get: {
//                                selectedMuscles.contains(muscle.id)
//                            },
//                            set: { newValue in
//                                if newValue {
//                                    selectedMuscles.insert(muscle.id)
//                                } else {
//                                    selectedMuscles.remove(muscle.id)
//                                }
//                            }
//                        )){
//                            ForEach(muscleViewModel.muscles, id:\.id){
//                                muscle in Text(muscle.i18NCode).tag(muscle.id)
//                            }
//                        }
//
//                    }
//                }
                Section(header: Text("Muscles")) {
                    if muscleViewModel.isLoading {
                        ProgressView("Loading ...")
                    } else if let error = muscleViewModel.errorMessage {
                        Text(error.message)
                            .foregroundColor(.red)
                    } else {
                        List(selection: $selectedMuscles) {
                            ForEach(muscleViewModel.muscles, id: \.id) { muscle in
                                Text(muscle.i18NCode)
                            }
                        }
                        // Force selection mode so multiple items can be selected.
                        .environment(\.editMode, .constant(.active))
                        // Adjust the frame as needed – for example, if you want a compact picker:
                        .frame(height: 250)
                    }
                }
                // Multi-Select Muscle Groups
//                Section(header: Text("Muscle Groups")) {
//                    if muscleGroupViewModel.isLoading {
//                        ProgressView("Loading ...")
//                    } else if let error = muscleGroupViewModel.errorMessage {
//                        Text(error.message)
//                            .foregroundColor(.red)
//                    } else {
//                        ForEach(muscleGroupViewModel.muscleGroups, id:\.id){
//                            group in Toggle(group.i18NCode, isOn: $selectedMuscleGroups.)
//
//                        }
                        ////                        ForEach(muscleGroupViewModel.muscleGroups, id: \.id) { group in
                        ////                            Toggle(group.i18NCode, isOn: Binding(
                        ////                                get: { selectedMuscleGroups.contains(group.id) },
                        ////                                set: { newValue in
                        ////                                    if newValue {
                        ////                                        selectedMuscleGroups.insert(group.id)
                        ////                                    } else {
                        ////                                        selectedMuscleGroups.remove(group.id)
                        ////                                    }
                        ////                                }
                        ////                            ))
                        //                        ForEach($muscleGroupViewModel.muscleGroups, id:\.id){
                        //                            $group in
                        //                            Toggle(group.i18NCode, selection: $group.value)
                        //
                        //                        }
//                    }
                    //                }
                    //
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
                    //                // Description Input
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
                //            .onChange(of: $exerciseViewModel.exerciseTypes) { oldValue, newValue in
                //                if let firstType = newValue.first {
                //                    selectedType = firstType.id
                //                }
                //            }
                .onAppear() {
                    Task{
//                        await muscleGroupViewModel.searchMuscleGroups()
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
        let exercise = CreateExerciseDto(
            i18NCode: name,
            description: description,
            muscleIds: selectedMuscles.isEmpty ? nil : Array(selectedMuscles),
            exerciseCategoryId: selectedExerciseCategory,
            imageData: imageData
        )
        Task {
            await exerciseViewModel.saveExercise(exerciseDto: exercise)
        }
    }
}

#Preview {
    AddExerciseView()
}
