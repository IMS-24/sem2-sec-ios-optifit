import SwiftUI

struct WorkoutListEntryView: View {
    @State var workout: GetWorkoutDto

    var body: some View {
        VStack(spacing: 8) {
            // First Row: Date and Time
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .foregroundColor(Color(.primaryAccent))
                    Text(
                        DateFormatter.localizedString(
                            from: workout.startAtUtc,
                            dateStyle: .medium,
                            timeStyle: .none)
                    )
                    .font(.headline)
                    .foregroundColor(Color(.primaryText))
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .foregroundColor(Color(.primaryAccent))
                    Text(
                        DateFormatter.localizedString(
                            from: workout.startAtUtc,
                            dateStyle: .none,
                            timeStyle: .short)
                    )
                    .font(.headline)
                    .foregroundColor(Color(.primaryText))
                }
            }

            // Second Row: Gym and Exercise Count
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "dumbbell")
                        .foregroundColor(Color("Success"))
                    Text(workout.gym.name)
                        .font(.subheadline)
                        .foregroundColor(Color(.primaryText))
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(Color(.primaryAccent))
                    Text("\(workout.workoutExercises?.count ?? 0)")
                        .font(.subheadline)
                        .foregroundColor(Color(.primaryText))
                }
            }

            // Third Row: Exercise Title and Notes Icon (if available)
            HStack {
                Text(workout.description)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.primaryText))
                Spacer()
                if let notes = workout.notes, !notes.isEmpty {
                    Image(systemName: "note.text")
                        .foregroundColor(Color(.secondaryAccent))
                }
            }
        }
        .padding()
        .background(Color(.secondaryBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
