import SwiftUI

struct ExerciseCategoryManagementView: View {
    @StateObject private var exerciseCategoriesViewModel = ExerciseCategoryViewModel()

    var body: some View {
        NavigationView {
            List(exerciseCategoriesViewModel.exerciseCategories) { exerciseCategory in
                Section(header: Text(exerciseCategory.i18NCode)) {
//                    ForEach(exerciseCategory.exerciseIds ?? []) { exercise in
//                        Text(exercise!)
//                    }
                }
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

#Preview {
    ExerciseCategoryManagementView()
}
