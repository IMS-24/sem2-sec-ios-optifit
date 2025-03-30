import SwiftUI

struct WorkoutOverviewSection: View {
    let start: String
    let end: String
    let gym: Components.Schemas.GetGymDto
    let summary: Components.Schemas.WorkoutSummary?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Date and Time Row
            HStack {
                Label(start, systemImage: "clock.fill")
                    .font(.subheadline)
                Spacer()
                Label(end, systemImage: "clock.arrow.circlepath")
                    .font(.subheadline)
            }
            // Gym Location Row
            HStack {
                Label("\(gym.name!), \(gym.city!)", systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                Spacer()
            }
            Divider()
            // Summary Stats Row
            HStack {
                if let summary = summary {
                    StatItemView(icon: "flame.fill", title: "Sets", value: "\(summary.totalSets!)")
                    Spacer()
                    StatItemView(icon: "number", title: "Reps", value: "\(summary.totalReps!)")
                    Spacer()
                    StatItemView(icon: "scalemass", title: "Weight", value: "\(summary.totalWeight!) kg")
                    Spacer()
                    StatItemView(icon: "list.number", title: "Ex.", value: "\(summary.totalExercises!)")
                }
            }

        }
        .padding()
        .background(Color(.secondaryBackground))
        .cornerRadius(12)

    }
}

#Preview {
    WorkoutOverviewSection(
        start: Date()
            .ISO8601Format(),
        end: Date()
            .ISO8601Format(),
        gym: Components.Schemas
            .GetGymDto(id: UUID().uuidString, name: "Home", address: "Daham", city: "Graz", zipCode: 8020),
        summary: Components.Schemas.WorkoutSummary(totalTime: 50, totalSets: 20, totalReps: 200, totalWeight: 155.50, totalExercises: 2))
}
