//
//  ExerciseWorkoutSummaryLineCharts.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 08.03.25.
//

import SwiftUI
import Charts
struct ExerciseWorkoutSummaryLineCharts: View {
    let workoutExercise: ExerciseWorkoutDto

    // Compute averages for each metric
    var avgWeight: Double {
        let values = workoutExercise.workoutSets.map { $0.weight }
        return values.isEmpty ? 0 : values.reduce(0, +) / Double(values.count)
    }
    
    var avgVolume: Double {
        let values = workoutExercise.workoutSets.map { $0.weight * Double($0.reps) }
        return values.isEmpty ? 0 : values.reduce(0, +) / Double(values.count)
    }
    
    var avgReps: Double {
        let values = workoutExercise.workoutSets.map { Double($0.reps) }
        return values.isEmpty ? 0 : values.reduce(0, +) / Double(values.count)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Weight Line Chart
            VStack(alignment: .leading) {
                Text("Weight")
                    .font(.headline)
                Chart {
                    ForEach(workoutExercise.workoutSets.sorted(by: { $0.order < $1.order })) { set in
                        LineMark(
                            x: .value("Set", set.order),
                            y: .value("Weight", set.weight)
                        )
                        PointMark(
                            x: .value("Set", set.order),
                            y: .value("Weight", set.weight)
                        )
                    }
                    // Average line for Weight
                    RuleMark(y: .value("Average", avgWeight))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(.blue)
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 150)
            }
            
            // Volume Line Chart (Weight x Reps)
            VStack(alignment: .leading) {
                Text("Volume (Weight x Reps)")
                    .font(.headline)
                Chart {
                    ForEach(workoutExercise.workoutSets.sorted(by: { $0.order < $1.order })) { set in
                        let volume = set.weight * Double(set.reps)
                        LineMark(
                            x: .value("Set", set.order),
                            y: .value("Volume", volume)
                        )
                        PointMark(
                            x: .value("Set", set.order),
                            y: .value("Volume", volume)
                        )
                    }
                    // Average line for Volume
                    RuleMark(y: .value("Average", avgVolume))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(.green)
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 150)
            }
            
            // Reps Line Chart
            VStack(alignment: .leading) {
                Text("Reps")
                    .font(.headline)
                Chart {
                    ForEach(workoutExercise.workoutSets.sorted(by: { $0.order < $1.order })) { set in
                        LineMark(
                            x: .value("Set", set.order),
                            y: .value("Reps", set.reps)
                        )
                        PointMark(
                            x: .value("Set", set.order),
                            y: .value("Reps", set.reps)
                        )
                    }
                    // Average line for Reps
                    RuleMark(y: .value("Average", avgReps))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(.red)
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 150)
            }
        }
        .padding()
    }
}
