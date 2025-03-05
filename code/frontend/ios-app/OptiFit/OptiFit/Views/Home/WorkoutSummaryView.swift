//
//  ActivityGraphView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI
import Charts

struct WorkoutSummaryView: View {
    // Mapping from a day (String) to a WorkoutSummary.
    var data: [String: WorkoutSummary]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Weekly Activity")
                    .font(.headline)
                    .padding(.leading)

            // Weekly activity chart using a bar chart.
            Chart {
                ForEach(data.sorted(by: { $0.key < $1.key }), id: \.key) { day, summary in
                    BarMark(
                            x: .value("Day", day),
                            y: .value("Total Time", summary.totalTime)
                    )
                            .foregroundStyle(.blue)
                }
            }
                    .frame(height: 200)
                    .padding()

            // Aggregated stats displayed in a two-column layout.
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    summaryStatView(title: "Total Time", value: totalTimeFormatted)
                    Spacer()
                    summaryStatView(title: "Total Sets", value: "\(totalSets)")
                }
                HStack {
                    summaryStatView(title: "Total Reps", value: "\(totalReps)")
                    Spacer()
                    summaryStatView(title: "Total Weight", value: "\(totalWeight) kg")
                }
                HStack {
                    summaryStatView(title: "Total Exercises", value: "\(totalExercises)")
                    Spacer()
                }
            }
                    .padding(.horizontal)
                    .padding(.bottom)
        }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.horizontal)
    }

    // MARK: - Helper View for Displaying a Summary Statistic
    @ViewBuilder
    private func summaryStatView(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            Text(value)
                    .font(.headline)
        }
    }

    // MARK: - Aggregated Computed Properties

    /// Total time summed over the week (assumed to be in minutes).
    private var totalTime: Int {
        data.values.reduce(0) {
            $0 + $1.totalTime
        }
    }

    /// Format total time as hours and minutes.
    private var totalTimeFormatted: String {
        let hours = totalTime / 60
        let minutes = totalTime % 60
        return "\(hours)h \(minutes)m"
    }

    private var totalSets: Int {
        data.values.reduce(0) {
            $0 + $1.totalSets
        }
    }

    private var totalReps: Int {
        data.values.reduce(0) {
            $0 + $1.totalReps
        }
    }

    private var totalWeight: Double {
        data.values.reduce(0.0) {
            $0 + (NSDecimalNumber(decimal: $1.totalWeight).doubleValue)
        }
    }

    private var totalExercises: Int {
        data.values.reduce(0) {
            $0 + $1.totalExercises
        }
    }
}

struct WorkoutSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        // Dummy data for previewing the summary view.
        let dummyData: [String: WorkoutSummary] = [
            "Mon": WorkoutSummary(totalTime: 90, totalSets: 10, totalReps: 120, totalWeight: 500, totalExercises: 5),
            "Tue": WorkoutSummary(totalTime: 75, totalSets: 8, totalReps: 100, totalWeight: 400, totalExercises: 4),
            "Wed": WorkoutSummary(totalTime: 60, totalSets: 6, totalReps: 80, totalWeight: 300, totalExercises: 3),
            "Thu": WorkoutSummary(totalTime: 120, totalSets: 12, totalReps: 150, totalWeight: 600, totalExercises: 6),
            "Fri": WorkoutSummary(totalTime: 80, totalSets: 7, totalReps: 90, totalWeight: 350, totalExercises: 4),
            "Sat": WorkoutSummary(totalTime: 100, totalSets: 9, totalReps: 110, totalWeight: 450, totalExercises: 5),
            "Sun": WorkoutSummary(totalTime: 70, totalSets: 7, totalReps: 85, totalWeight: 320, totalExercises: 4)
        ]
        WorkoutSummaryView(data: dummyData)
    }
}
