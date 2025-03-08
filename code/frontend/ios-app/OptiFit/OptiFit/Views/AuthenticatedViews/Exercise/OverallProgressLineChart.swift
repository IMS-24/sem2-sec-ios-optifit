import SwiftUI
import Charts

/// Aggregated data for one workout exercise.
struct AggregatedExerciseData: Identifiable {
    let id: UUID
    let order: Int
    let totalWeight: Double   // Sum of weight * reps
    let totalReps: Int        // Sum of reps
    let totalSets: Int        // Number of sets
}

struct OverallProgressLineChart: View {
    let workoutExercises: [ExerciseWorkoutDto]
    
    /// Compute aggregated data for each workout exercise.
    var aggregatedData: [AggregatedExerciseData] {
        workoutExercises.map { exercise in
            let totalWeight = exercise.workoutSets.reduce(0) { $0 + ($1.weight * Double($1.reps)) }
            let totalReps = exercise.workoutSets.reduce(0) { $0 + $1.reps }
            let totalSets = exercise.workoutSets.count
            return AggregatedExerciseData(id: exercise.id, order: exercise.order, totalWeight: totalWeight, totalReps: totalReps, totalSets: totalSets)
        }
        .sorted(by: { $0.order < $1.order })
    }
    
    // Maximum values from the aggregated data for normalization.
    var maxTotalWeight: Double {
        aggregatedData.map { $0.totalWeight }.max() ?? 1
    }
    var maxTotalReps: Double {
        aggregatedData.map { Double($0.totalReps) }.max() ?? 1
    }
    var maxTotalSets: Double {
        aggregatedData.map { Double($0.totalSets) }.max() ?? 1
    }
    
    // Averages (raw)
    var avgTotalWeight: Double {
        let sum = aggregatedData.map { $0.totalWeight }.reduce(0, +)
        return aggregatedData.isEmpty ? 0 : sum / Double(aggregatedData.count)
    }
    var avgTotalReps: Double {
        let sum = aggregatedData.map { Double($0.totalReps) }.reduce(0, +)
        return aggregatedData.isEmpty ? 0 : sum / Double(aggregatedData.count)
    }
    var avgTotalSets: Double {
        let sum = aggregatedData.map { Double($0.totalSets) }.reduce(0, +)
        return aggregatedData.isEmpty ? 0 : sum / Double(aggregatedData.count)
    }
    
    var body: some View {
        VStack{
            Chart {
                // Weight line series (normalized)
                ForEach(aggregatedData) { data in
                    LineMark(
                        x: .value("Workout", data.order),
                        y: .value("Normalized Weight", data.totalWeight / maxTotalWeight)
                    )
                    .foregroundStyle(.blue)
                    PointMark(
                        x: .value("Workout", data.order),
                        y: .value("Normalized Weight", data.totalWeight / maxTotalWeight)
                    )
                    .foregroundStyle(.blue)
                }
                RuleMark(y: .value("Avg Weight", avgTotalWeight / maxTotalWeight))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundStyle(.blue)
                
                // Reps line series (normalized)
                ForEach(aggregatedData) { data in
                    LineMark(
                        x: .value("Workout", data.order),
                        y: .value("Normalized Reps", Double(data.totalReps) / maxTotalReps)
                    )
                    .foregroundStyle(.red)
                    PointMark(
                        x: .value("Workout", data.order),
                        y: .value("Normalized Reps", Double(data.totalReps) / maxTotalReps)
                    )
                    .foregroundStyle(.red)
                }
                RuleMark(y: .value("Avg Reps", avgTotalReps / maxTotalReps))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundStyle(.red)
                
                // Sets line series (normalized)
                ForEach(aggregatedData) { data in
                    LineMark(
                        x: .value("Workout", data.order),
                        y: .value("Normalized Sets", Double(data.totalSets) / maxTotalSets)
                    )
                    .foregroundStyle(.green)
                    PointMark(
                        x: .value("Workout", data.order),
                        y: .value("Normalized Sets", Double(data.totalSets) / maxTotalSets)
                    )
                    .foregroundStyle(.green)
                }
                RuleMark(y: .value("Avg Sets", avgTotalSets / maxTotalSets))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundStyle(.green)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            // All values are normalized to 0...1.
            .chartYScale(domain: 0...1)
            .frame(height: 250)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
        .shadow(radius: 1)
        .padding(.horizontal)
    }
}
