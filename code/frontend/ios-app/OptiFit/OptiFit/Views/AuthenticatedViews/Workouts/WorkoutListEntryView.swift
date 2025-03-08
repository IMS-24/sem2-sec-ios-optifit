import SwiftUI

struct WorkoutListEntryView: View {
    @State var workout: GetWorkoutDto
    
    var body: some View {
        VStack(spacing: 8) {
            // First Row: Date and Time
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .foregroundColor(Color("PrimaryAccent"))
                    Text(DateFormatter.localizedString(from: workout.startAtUtc,
                                                       dateStyle: .medium,
                                                       timeStyle: .none))
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .foregroundColor(Color("PrimaryAccent"))
                    Text(DateFormatter.localizedString(from: workout.startAtUtc,
                                                       dateStyle: .none,
                                                       timeStyle: .short))
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                }
            }
            
            // Second Row: Gym and Exercise Count
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "dumbbell")
                        .foregroundColor(Color("Success"))
                    Text(workout.gym.name)
                        .font(.subheadline)
                        .foregroundColor(Color("PrimaryText"))
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(Color("PrimaryAccent"))
                    Text("\(workout.workoutExercises?.count ?? 0)")
                        .font(.subheadline)
                        .foregroundColor(Color("PrimaryText"))
                }
            }
            
            // Third Row: Exercise Title and Notes Icon (if available)
            HStack {
                Text(workout.description)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color("PrimaryText"))
                Spacer()
                if let notes = workout.notes, !notes.isEmpty {
                    Image(systemName: "note.text")
                        .foregroundColor(Color("SecondaryAccent"))
                }
            }
        }
        .padding()
        .background(Color("SecondaryBackground"))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
