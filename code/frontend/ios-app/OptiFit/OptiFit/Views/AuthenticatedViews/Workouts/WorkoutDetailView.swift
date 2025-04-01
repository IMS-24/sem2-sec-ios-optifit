import SwiftUI

struct WorkoutDetailView: View {
    let workout: Components.Schemas.GetWorkoutDto

    @State private var isEditing = false
    @State private var descriptionText: String
    @State private var notesText: String

    // Initialize state with workout’s current data.
    init(workout: Components.Schemas.GetWorkoutDto) {
        self.workout = workout
        _descriptionText = State(initialValue: workout.description!)
        _notesText = State(initialValue: workout.notes ?? "")
    }

    // MARK: - Computed Properties

    private var formattedStart: String {
        DateFormatter.localizedString(from: workout.startAtUtc!, dateStyle: .medium, timeStyle: .short)
    }

    private var formattedEnd: String {
        if let endDate = workout.endAtUtc {
            if Calendar.current.isDate(workout.startAtUtc!, inSameDayAs: endDate) {
                return DateFormatter.localizedString(from: endDate, dateStyle: .none, timeStyle: .short)
            } else {
                return DateFormatter.localizedString(from: endDate, dateStyle: .medium, timeStyle: .short)
            }
        }
        return "Ongoing"
    }

    private var summary: Components.Schemas.WorkoutSummary? {
        workout.workoutSummary
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                //                // Workout Overview Section with icons and stats.
                WorkoutOverviewSection(
                    start: formattedStart,
                    end: formattedEnd,
                    gym: workout.gym!,
                    summary: summary
                )

                // Description Section
                Section(header: Text("Description").font(.headline)) {
                    if isEditing {
                        TextField("Description", text: $descriptionText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(descriptionText)
                    }
                }
                .padding(.horizontal)

                // Exercises Section – List of performed exercises.
                WorkoutExercisesView(workout: workout)
                // Notes Section
                Section(header: Text("Notes").font(.headline)) {
                    if isEditing {
                        TextField("Notes", text: $notesText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(notesText)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Workout Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            }
        }
    }
}

#Preview {
    WorkoutDetailView(
        workout: Components.Schemas.GetWorkoutDto(
            id: UUID().uuidString,
            description: "",
            startAtUtc: Date(),
            endAtUtc: Date(),
            notes: "Notes",
            gymId: UUID().uuidString,
            gym: Components.Schemas.GetGymDto(
                id: UUID().uuidString,
                name: "Home",
                address: "Daham",
                city: "Graz",
                zipCode: 8020
            ),
            workoutExercises: [
                .init(id: UUID().uuidString, order: 1, workoutId: "", exercise: .init(id: UUID().uuidString, i18NCode: "Bench Press"), workoutSets: [
                    .init(id: "1", order: 1, reps: 10, weight: 25.50, workoutExerciseId: ""),
                ], notes: "Some Notes")
            ],
            workoutSummary: Components.Schemas.WorkoutSummary(totalTime: 10, totalSets: 20, totalReps: 30, totalWeight: 155.50, totalExercises: 10)))
}
