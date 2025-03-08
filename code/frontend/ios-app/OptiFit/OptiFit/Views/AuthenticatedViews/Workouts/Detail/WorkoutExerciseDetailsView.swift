import SwiftUI

struct WorkoutExerciseDetailsView: View {
    let exercise: GetWorkoutExerciseDto
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header: Exercise title and description.
                VStack(alignment: .leading, spacing: 8) {
                    Text(exercise.exercise.i18NCode)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryText"))
                    if let desc = exercise.exercise.description, !desc.isEmpty {
                        Text(desc)
                            .font(.body)
                            .foregroundColor(Color("PrimaryText"))
                    }
                }
                .padding(.horizontal)
                
                // Instead of one combined bar chart, show each set as its own graphical card.
                if let sets = exercise.workoutSets, !sets.isEmpty {
                    Text("Set Details")
                        .font(.headline)
                        .padding(.horizontal)
                    ForEach(sets.sorted(by: { $0.order < $1.order })) { set in
                        WorkoutSetSummaryView(set: set)
                            .padding(.horizontal)
                    }
                } else {
                    Text("No sets available.")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Exercise Details")
    }
}
#Preview {
    WorkoutExerciseDetailsView(exercise: GetWorkoutExerciseDto(
        id: UUID(),
        order: 1,
        workoutId: UUID(),
        exercise: GetExerciseDto(
            id: UUID(),
            i18NCode: "Exercise Name",
            description: "Exercise Description",
            exerciseCategoryId: UUID(),
            exerciseCategory: "Legs"),
        workoutSets: [
            GetWorkoutSetDto(id: UUID(), order: 5, reps: 100, weight: 150, workoutExerciseId: UUID()),
            GetWorkoutSetDto(id: UUID(), order: 3, reps: 100, weight: 150, workoutExerciseId: UUID()),
            GetWorkoutSetDto(id: UUID(), order: 1, reps: 10, weight: 20, workoutExerciseId: UUID()),
            GetWorkoutSetDto(id: UUID(), order: 2, reps: 100, weight: 150, workoutExerciseId: UUID()),
            GetWorkoutSetDto(id: UUID(), order: 4, reps: 100, weight: 150, workoutExerciseId: UUID()),
            GetWorkoutSetDto(id: UUID(), order: 6, reps: 100, weight: 150, workoutExerciseId: UUID())
        ],
        notes: "Some Notes"
    )
    )
}
