import SwiftUI

struct WorkoutOverviewSection: View {
    let start: String
    let end: String
    let gym: GetGymDto
    let summary: WorkoutSummary
    
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
                Label("\(gym.name), \(gym.city)", systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                Spacer()
            }
            Divider()
            // Summary Stats Row
            HStack(spacing: 16) {
                StatItemView(icon: "flame.fill", title: "Sets", value: "\(summary.totalSets)")
                StatItemView(icon: "number", title: "Reps", value: "\(summary.totalReps)")
                StatItemView(icon: "scalemass", title: "Weight", value: "\(summary.totalWeight) kg")
                StatItemView(icon: "list.number", title: "Ex.", value: "\(summary.totalExercises)")
            }
        }
        .padding()
        .background(Color("SecondaryBackground"))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    WorkoutOverviewSection(start: Date().ISO8601Format(), end: Date().ISO8601Format(), gym: GetGymDto(address: "Daham", zipCode: 8020, id: UUID(), name: "Home", city: "Graz"), summary: WorkoutSummary(totalTime: 50, totalSets: 20, totalReps: 200, totalWeight: 155.50, totalExercises: 2))
}
