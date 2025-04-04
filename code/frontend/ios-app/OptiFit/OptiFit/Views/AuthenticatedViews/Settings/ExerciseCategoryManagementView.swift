import SwiftUI

struct ExerciseCategoryManagementView: View {
    @EnvironmentObject var exerciseCategoriesViewModel: ExerciseCategoryViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(exerciseCategoriesViewModel.exerciseCategories, id: \.id) { key in
                    Text(key.i18NCode!)
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


struct ExerciseCategoryManagementViewWrapper: View {
    
    let viewModel = ExerciseCategoryViewModel(exerciseService: MockExerciseService())
    
    var body: some View {
        ExerciseCategoryManagementView()
            .environmentObject(viewModel)
    }
}
struct ExerciseCategoryManagementView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCategoryManagementViewWrapper()
    }
}
