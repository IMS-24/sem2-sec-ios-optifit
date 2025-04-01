import Charts
import SwiftUI

struct ExerciseWorkoutSummaryLineCharts: View {
    let workoutExercise: Components.Schemas.ExerciseWorkoutDto
    
    // Compute averages for each metric safely
    var avgWeight: Double {
        let sets = workoutExercise.workoutSets ?? []
        let values = sets.compactMap { $0.weight }
        return values.isEmpty ? 0 : values.reduce(0, +) / Double(values.count)
    }
    
    var avgVolume: Double {
        let sets = workoutExercise.workoutSets ?? []
        let values = sets.compactMap { set -> Double? in
            guard let weight = set.weight, let reps = set.reps else { return nil }
            return weight * Double(reps)
        }
        return values.isEmpty ? 0 : values.reduce(0, +) / Double(values.count)
    }
    
    var avgReps: Double {
        let sets = workoutExercise.workoutSets ?? []
        let values = sets.compactMap { set -> Double? in
            guard let reps = set.reps else { return nil }
            return Double(reps)
        }
        return values.isEmpty ? 0 : values.reduce(0, +) / Double(values.count)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Weight Line Chart
            VStack(alignment: .leading) {
                Text("Weight")
                    .font(.headline)
                Chart {
                    ForEach((workoutExercise.workoutSets ?? []).sorted(by: { ($0.order ?? 0) < ($1.order ?? 0) }), id: \.self) { set in
                        LineMark(
                            x: .value("Set", set.order ?? 0),
                            y: .value("Weight", set.weight ?? 0)
                        )
                        .foregroundStyle(.red)
                        
                        PointMark(
                            x: .value("Set", set.order ?? 0),
                            y: .value("Weight", set.weight ?? 0)
                        )
                        .foregroundStyle(by: .value("order", String(set.order ?? 0)))
                    }
                    // Average line for Weight
                    RuleMark(y: .value("Average", avgWeight))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(Color(.primaryAccent))
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
                    ForEach((workoutExercise.workoutSets ?? []).sorted(by: { ($0.order ?? 0) < ($1.order ?? 0) }), id: \.self) { set in
                        let volume = (set.weight ?? 0) * Double(set.reps ?? 0)
                        LineMark(
                            x: .value("Set", set.order ?? 0),
                            y: .value("Volume", volume)
                        )
                        .foregroundStyle(.yellow)
                        
                        PointMark(
                            x: .value("Set", set.order ?? 0),
                            y: .value("Volume", volume)
                        )
                        .foregroundStyle(by: .value("order", String(set.order ?? 0)))
                    }
                    // Average line for Volume
                    RuleMark(y: .value("Average", avgVolume))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(Color(.primaryAccent))
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
                    ForEach((workoutExercise.workoutSets ?? []).sorted(by: { ($0.order ?? 0) < ($1.order ?? 0) }), id: \.self) { set in
                        LineMark(
                            x: .value("Set", set.order ?? 0),
                            y: .value("Reps", set.reps ?? 0)
                        )
                        .foregroundStyle(.green)
                        
                        PointMark(
                            x: .value("Set", set.order ?? 0),
                            y: .value("Reps", set.reps ?? 0)
                        )
                        .foregroundStyle(by: .value("order", String(set.order ?? 0)))
                    }
                    // Average line for Reps
                    RuleMark(y: .value("Average", avgReps))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(Color(.primaryAccent))
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
