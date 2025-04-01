import SwiftUI

struct MuscleManagementView: View {
    @StateObject private var muscleViewModel = MuscleViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(muscleViewModel.muscles, id: \.id) { key in
                    Text(key.i18NCode!)
                }
            }
            .navigationTitle("Muscles")
            .onAppear {
                Task {
                    await muscleViewModel.searchMuscles()
                }
            }
            .alert(item: $muscleViewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }

}

#Preview {
    MuscleManagementView()
}
