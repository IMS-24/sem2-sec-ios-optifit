
import SwiftUI

struct ExerciseCategorySection: View {
    @Binding var selectedExerciseCategory: Components.Schemas.GetExerciseCategoryDto?
    @EnvironmentObject var exerciseViewModel: ExerciseViewModel
    @EnvironmentObject var exerciseCategoryViewModel: ExerciseCategoryViewModel
    
    var body: some View {
        Section(header: Text("Exercise Category").font(.headline)) {
            if exerciseViewModel.isLoading {
                ProgressView("Loading …")
            } else if let error = exerciseViewModel.errorMessage {
                Text(error.message)
                    .foregroundColor(.red)
            } else {
                Picker(selection: $selectedExerciseCategory, label: Text("Select Category")) {
                    ForEach(exerciseCategoryViewModel.exerciseCategories, id: \.id) { category in
                        Text(category.i18NCode!)
                            .tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}
