//
//  SetGraphicalRepresentationView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 06.03.25.
//


import SwiftUI

struct WorkoutSetSummaryView: View {
    let set: GetWorkoutSetDto
    // Assumed maximum values to normalize the gauge.
    let maxReps: Int = 20
    let maxWeight: Double = 100.0
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Set \(set.order)")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                Spacer()
            }
            HStack(spacing: 16) {
                // Gauge for reps.
                VStack {
                    Text("Reps: \(set.reps)")
//                    Gauge(value: Double(set.reps), in: 0...Double(maxReps)) {
//                        Text("Reps")
//                            .font(.caption2)
//                    }
//                    .gaugeStyle(.accessoryCircular)
//                    Text("\(set.reps) Reps")
//                        .font(.caption)
                }
                // Gauge for weight.
                VStack {
                    Text("Weight: \(set.weight, specifier: "%.1f")")
//                    Gauge(value: set.weight, in: 0...maxWeight) {
//                        Text("Weight")
//                            .font(.caption2)
//                    }
//                    .gaugeStyle(.accessoryCircular)
//                    Text("\(set.weight, specifier: "%.1f") kg")
//                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color("SecondaryBackground"))
        .cornerRadius(10)
    }
}
#Preview {
    WorkoutSetSummaryView(set: .init(id: UUID(), order: 1, reps: 10, weight: 20.0, workoutExerciseId: UUID()))
}
