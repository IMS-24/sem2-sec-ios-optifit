import SwiftUI

extension Components.Schemas.GetMuscleDto {
    var groupNames: [String] {
        // If there is no mapping, we return "Ungrouped"
        guard let mappings = groupMapping, !mappings.isEmpty else {
            return ["Ungrouped"]
        }
        // Assuming that each mapping has a muscleGroup with a `name` property.
        let names = mappings.compactMap { $0.muscleGroup?.i18NCode }
        return names.isEmpty ? ["Ungrouped"] : names
    }
}
struct MuscleManagementView: View {
    @EnvironmentObject var muscleViewModel: MuscleViewModel

    private var groupedMuscles: [String: [Components.Schemas.GetMuscleDto]] {
        let muscles = muscleViewModel.muscles
        var groups: [String: [Components.Schemas.GetMuscleDto]] = [:]
        for muscle in muscles {
            for groupName in muscle.groupNames {
                groups[groupName, default: []].append(muscle)
            }
        }
        return groups
    }

    var body: some View {
        NavigationView {
            List {
                GroupedMuscleListView(groupedMuscles: groupedMuscles)
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

struct MuscleManagementViewWrapper: View {

    let viewModel = MuscleViewModel(muscleService: MockMuscleService())

    var body: some View {
        MuscleManagementView()
            .environmentObject(viewModel)
    }
}
struct MuscleManagementView_Previews: PreviewProvider {
    static var previews: some View {
        MuscleManagementViewWrapper()
    }
}
