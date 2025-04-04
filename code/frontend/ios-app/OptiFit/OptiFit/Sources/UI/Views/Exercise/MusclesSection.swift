import SwiftUI

struct MusclesSection: View {
    @Binding var selectedMuscles: Set<Components.Schemas.GetMuscleDto>
    @EnvironmentObject var muscleViewModel: MuscleViewModel
    
    // Group muscles by their primary group name (using the first mapping if available)
    private var groupedMuscles: [String: [Components.Schemas.GetMuscleDto]] {
        var groups: [String: [Components.Schemas.GetMuscleDto]] = [:]
        for muscle in muscleViewModel.muscles {
            let groupName: String
            if let firstGroup = muscle.groupMapping?.first?.muscleGroup?.i18NCode, !firstGroup.isEmpty {
                groupName = firstGroup.capitalized
            } else {
                groupName = "Ungrouped"
            }
            groups[groupName, default: []].append(muscle)
        }
        return groups
    }
    
    var body: some View {
        if muscleViewModel.isLoading {
            ProgressView("Loading …")
        } else if let error = muscleViewModel.errorMessage {
            Text(error.message)
                .foregroundColor(.red)
        } else {
            // Iterate over the groups sorted by group name.
            ForEach(groupedMuscles.keys.sorted(), id: \.self) { group in
                Section(header: Text(group).font(.headline)) {
                    ForEach(groupedMuscles[group]!, id: \.id) { muscle in
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
                            Text(muscle.i18NCode ?? "Unknown")
                        }
                    }
                }
            }
        }
    }
}
