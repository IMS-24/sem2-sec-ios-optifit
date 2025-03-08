import SwiftUI

struct WorkoutDetailView: View {
    let workout: GetWorkoutDto
    
    @State private var isEditing = false
    @State private var descriptionText: String
    @State private var notesText: String
    
    // Initialize state with workout’s current data.
    init(workout: GetWorkoutDto) {
        self.workout = workout
        _descriptionText = State(initialValue: workout.description)
        _notesText = State(initialValue: workout.notes ?? "")
    }
    
    // MARK: - Computed Properties
    
    private var formattedStart: String {
        DateFormatter.localizedString(from: workout.startAtUtc, dateStyle: .medium, timeStyle: .short)
    }
    
    private var formattedEnd: String {
        if let endDate = workout.endAtUtc {
            if Calendar.current.isDate(workout.startAtUtc, inSameDayAs: endDate) {
                return DateFormatter.localizedString(from: endDate, dateStyle: .none, timeStyle: .short)
            } else {
                return DateFormatter.localizedString(from: endDate, dateStyle: .medium, timeStyle: .short)
            }
        }
        return "Ongoing"
    }
    
    private var summary: WorkoutSummary? {
        workout.workoutSummary
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Workout Overview Section with icons and stats.
                WorkoutOverviewSection(
                    start: formattedStart,
                    end: formattedEnd,
                    gym: workout.gym,
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
                
                // Exercises Section – List of performed exercises.
                VStack(alignment: .leading, spacing: 8) {
                    Text("Exercises")
                        .font(.headline)
                        .padding(.horizontal)
                    if let exercises = workout.workoutExercises, !exercises.isEmpty {
                        ForEach(exercises) { exercise in
                            NavigationLink {
                                WorkoutExerciseDetailsView(exercise: exercise)
                            } label: {
                                HStack {
                                    Text(exercise.exercise.i18NCode)
                                        .font(.body)
                                        .foregroundColor(Color("PrimaryText"))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color("SecondaryBackground"))
                                .cornerRadius(8)
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        Text("No exercises available.")
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                }
                
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
    WorkoutDetailView(workout: GetWorkoutDto(id: UUID(), description: "", startAtUtc: Date(), endAtUtc: Date(), notes: "Notes", gymId: UUID(), gym: GetGymDto(address: "Daham", zipCode: 8020, id: UUID(), name: "Home", city: "Graz"), workoutExercises: [], workoutSummary: WorkoutSummary(totalTime: 10, totalSets: 20, totalReps: 30, totalWeight: 155.50, totalExercises: 10)))
}
