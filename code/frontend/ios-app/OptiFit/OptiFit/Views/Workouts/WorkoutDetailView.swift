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
    
    var body: some View {
        Form {
            Section(header: Text("Workout Info")) {
                Text("Start: \(DateFormatter.localizedString(from: workout.startAtUtc, dateStyle: .medium, timeStyle: .short))")
                if let endDate = workout.endAtUtc {
                    Text("End: \(DateFormatter.localizedString(from: endDate, dateStyle: .medium, timeStyle: .short))")
                }
            }
            
            Section(header: Text("Description")) {
                if isEditing {
                    TextField("Description", text: $descriptionText)
                } else {
                    Text(descriptionText)
                }
            }
            
            Section(header: Text("Notes")) {
                if isEditing {
                    TextField("Notes", text: $notesText)
                } else {
                    Text(notesText)
                }
            }
            
            // Optionally: add sections for workout exercises if needed
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
