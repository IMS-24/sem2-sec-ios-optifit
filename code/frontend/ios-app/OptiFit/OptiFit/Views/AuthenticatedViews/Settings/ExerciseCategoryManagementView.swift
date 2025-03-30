import SwiftUI

struct ExerciseCategoryManagementView: View {
    @StateObject private var exerciseCategoriesViewModel = ExerciseCategoryViewModel()

    var body: some View {
        NavigationView {
//             ForEach(workoutExercises.indices, id: \.self) { index in
            //            (exerciseCategoriesViewModel.exerciseCategories)
            List{
                
                ForEach(exerciseCategoriesViewModel.exerciseCategories, id: \.self){ exerciseCategory in
                    Section(header: Text(exerciseCategory.i18NCode!)) {
                    }
                    .navigationTitle("Exercise Categories")
                    .onAppear {
                        Task {
                            await exerciseCategoriesViewModel.fetchCategories()
                        }
                    }
                    .alert(item: $exerciseCategoriesViewModel.errorMessage) { error in
                        Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }
}

#Preview {
    ExerciseCategoryManagementView()
}
