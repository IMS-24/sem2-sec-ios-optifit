import SwiftUI

struct ExerciseMuscleGroupView: View {
    // Muscle mapping passed in contains intensity and embedded muscle data.
    var muscleMapping: [Components.Schemas.GetExerciseMuscleMappingDto]?

    // Group the muscle mappings by their muscle group name and sum intensities.
    var groupedIntensity: [String: Int32] {
        var groups: [String: Int32] = [:]
        muscleMapping?.forEach { mapping in
            // Use all available group mappings for a muscle.
            if let muscleGroups = mapping.muscleDto?.groupMapping, !muscleGroups.isEmpty {
                for groupMapping in muscleGroups {
                    // Use the muscle group i18NCode or fall back to "Ungrouped"
                    let groupName = groupMapping.muscleGroup?.i18NCode ?? "Ungrouped"
                    groups[groupName, default: 0] += mapping.intensity ?? 0
                }
            } else {
                groups["Ungrouped", default: 0] += mapping.intensity ?? 0
            }
        }
        return groups
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Muscle Groups Overview")
                .font(.title2)
                .bold()

            if groupedIntensity.isEmpty {
                Text("No muscle data available")
                    .foregroundColor(.gray)
            } else {
                // Determine the maximum intensity to normalize the progress bars.
                let maxIntensity = groupedIntensity.values.max() ?? 1

                ForEach(groupedIntensity.keys.sorted(), id: \.self) { group in
                    let intensity = groupedIntensity[group] ?? 0
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(group.capitalized)
                                .font(.headline)
                            Spacer()
                            Text("\(intensity)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                // Background bar.
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                // Foreground bar with width relative to max intensity.
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: CGFloat(intensity) / CGFloat(maxIntensity) * geometry.size.width)
                            }
                            .cornerRadius(4)
                        }
                        .frame(height: 10)
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.secondarySystemBackground))
                    )
                }
            }
        }
        .padding()
    }
}
