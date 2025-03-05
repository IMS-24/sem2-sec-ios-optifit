//
//  WorkoutDetailView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 05.03.25.
//

import SwiftUI

struct WorkoutDetailView: View {
    let workout: GetWorkoutDto
    
    @State private var isEditing = false
    @State private var descriptionText: String
    @State private var notesText: String
    
    // Initialize the state with the workout’s current data.
    init(workout: GetWorkoutDto) {
        self.workout = workout
        _descriptionText = State(initialValue: workout.description)
        _notesText = State(initialValue: workout.notes ?? "")
    }
    
    // MARK: - Computed Properties for Calculated Stats
    
    /// Returns the formatted duration between start and end times (or "Ongoing").
    private var workoutDuration: String {
        if let end = workout.endAtUtc {
            let interval = end.timeIntervalSince(workout.startAtUtc)
            return formatDuration(interval)
        }
        return "Ongoing"
    }
    
    /// The total number of exercises in the workout.
    private var totalExercises: Int {
        workout.workoutExercises?.count ?? 0
    }
    
    /// The total number of sets across all exercises.
    private var totalSets: Int {
        workout.workoutExercises?.reduce(0) { result, exercise in
            result + (exercise.workoutSets?.count ?? 0)
        } ?? 0
    }
    
    /// The total number of reps from all sets.
    private var totalReps: Int {
        workout.workoutExercises?.reduce(0) { result, exercise in
            result + (exercise.workoutSets?.reduce(0) { $0 + $1.reps } ?? 0)
        } ?? 0
    }
    
    /// Total weight lifted calculated as sum(reps × weight) for each set.
    private var totalWeightLifted: Double {
        workout.workoutExercises?.reduce(0.0) { result, exercise in
            result + (exercise.workoutSets?.reduce(0.0) { $0 + (Double($1.reps) * $1.weight) } ?? 0.0)
        } ?? 0.0
    }
    
    /// Average weight per rep.
    private var averageWeightPerRep: Double {
        totalReps > 0 ? totalWeightLifted / Double(totalReps) : 0.0
    }
    
    /// Helper to format a time interval into a string (e.g., "1h 23m 45s").
    private func formatDuration(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: interval) ?? ""
    }
    
    /// Computed property for formatted start date.
    private var formattedStart: String {
        DateFormatter.localizedString(from: workout.startAtUtc, dateStyle: .medium, timeStyle: .short)
    }
    
    /// Computed property for formatted end date.
    private var formattedEnd: String {
        if let endDate = workout.endAtUtc {
            if Calendar.current.isDate(workout.startAtUtc, inSameDayAs: endDate) {
                // If the start and end are on the same day, show only the time for the end.
                return DateFormatter.localizedString(from: endDate, dateStyle: .none, timeStyle: .short)
            } else {
                return DateFormatter.localizedString(from: endDate, dateStyle: .medium, timeStyle: .short)
            }
        }
        return "N/A"
    }
    
    var body: some View {
        Form {
            // MARK: - Workout Summary Section
            Section(header: Text("Workout Summary")) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Start")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(formattedStart)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("End")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(formattedEnd)
                    }
                }
                VStack(alignment: .leading) {
                    Text("Gym")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(workout.gym.name)
                        .font(.footnote)
                }
            }
            
            // MARK: - Description Section
            Section(header: Text("Description")) {
                if isEditing {
                    TextField("Description", text: $descriptionText)
                } else {
                    Text(descriptionText)
                }
            }
            
            // MARK: - Notes Section
            Section(header: Text("Notes")) {
                if isEditing {
                    TextField("Notes", text: $notesText)
                } else {
                    Text(notesText)
                }
            }
            
            // MARK: - Calculated Stats Section
            Section(header: Text("Calculated Stats")) {
                HStack {
                    Text("Duration:")
                    Spacer()
                    Text(workoutDuration)
                }
                HStack {
                    Text("Total Exercises:")
                    Spacer()
                    Text("\(totalExercises)")
                }
                HStack {
                    Text("Total Sets:")
                    Spacer()
                    Text("\(totalSets)")
                }
                HStack {
                    Text("Total Reps:")
                    Spacer()
                    Text("\(totalReps)")
                }
                HStack {
                    Text("Total Weight Lifted:")
                    Spacer()
                    Text("\(totalWeightLifted, specifier: "%.2f") kg")
                }
                HStack {
                    Text("Avg Weight/Rep:")
                    Spacer()
                    Text("\(averageWeightPerRep, specifier: "%.2f") kg")
                }
            }
        }
        .navigationTitle("Workout Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Done" : "Edit") {
                    // When turning off editing, you could call your save function here.
                    isEditing.toggle()
                }
            }
        }
    }
}
