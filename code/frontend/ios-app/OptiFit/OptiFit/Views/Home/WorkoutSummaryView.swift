import SwiftUI
import Charts

struct WorkoutSummaryView: View {
    // Mapping from a complete day string ("yyyy-MM-dd") to a WorkoutSummary.
    var data: [String: WorkoutSummary]
    // The Monday date for the currently selected week.
    var currentMonday: Date
    
    // Helper to convert a complete day string to a weekday abbreviation.
    private func weekdayString(from key: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = inputFormatter.date(from: key) else { return key }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE" // e.g. "Mon", "Tue"
        return outputFormatter.string(from: date)
    }
    
    // Compute the current week number using currentMonday.
    private var currentWeekNumber: Int {
        Calendar.current.component(.weekOfYear, from: currentMonday)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Display the current week number.
            HStack {
                Text("Week \(currentWeekNumber)")
                    .font(.subheadline)
                    .padding(.leading)
                Spacer()
            }
            Text("Weekly Activity")
                .font(.headline)
                .padding(.leading)
            
            if data.isEmpty {
                // Placeholder view if no data is available.
                VStack {
                    Spacer()
                    Image(systemName: "calendar.badge.exclamationmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text("No workout data available for this week")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(height: 250)
            } else {
                // Weekly activity chart using a bar chart.
                Chart {
                    ForEach(data.sorted(by: { $0.key < $1.key }), id: \.key) { dayKey, summary in
                        BarMark(
                            x: .value("Day", weekdayString(from: dayKey)),
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
                
                // Fancy horizontal card view for daily summaries.
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(data.sorted(by: { $0.key < $1.key }), id: \.key) { key, summary in
                            DailySummaryCard(dayKey: key, summary: summary)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 150)
            }
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
        data.values.reduce(0) { $0 + $1.totalTime }
    }
    
    /// Format total time as hours and minutes.
    private var totalTimeFormatted: String {
        let hours = totalTime / 60
        let minutes = totalTime % 60
        return "\(hours)h \(minutes)m"
    }
    
    private var totalSets: Int {
        data.values.reduce(0) { $0 + $1.totalSets }
    }
    
    private var totalReps: Int {
        data.values.reduce(0) { $0 + $1.totalReps }
    }
    
    private var totalWeight: Double {
        data.values.reduce(0.0) {
            $0 + (NSDecimalNumber(decimal: $1.totalWeight).doubleValue)
        }
    }
    
    private var totalExercises: Int {
        data.values.reduce(0) { $0 + $1.totalExercises }
    }
}

// A fancy card view for daily summaries.
struct DailySummaryCard: View {
    let dayKey: String
    let summary: WorkoutSummary
    
    // Convert the complete day string to a weekday abbreviation.
    private var weekday: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = inputFormatter.date(from: dayKey) else { return dayKey }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE"
        return outputFormatter.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(weekday)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.top, 8)
            Divider().background(Color.white)
            VStack(spacing: 4) {
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.white)
                        .font(.caption)
                    Text("\(summary.totalTime) min")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.white)
                        .font(.caption)
                    Text("\(summary.totalSets) sets")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                HStack {
                    Image(systemName: "repeat")
                        .foregroundColor(.white)
                        .font(.caption)
                    Text("\(summary.totalReps) reps")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 8)
        }
        .frame(width: 120, height: 120)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(15)
        .shadow(radius: 4)
    }
}

struct WorkoutSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        // Dummy data for previewing the summary view.
        let dummyData: [String: WorkoutSummary] = [
            "2025-03-09": WorkoutSummary(totalTime: 90, totalSets: 10, totalReps: 120, totalWeight: 500, totalExercises: 5),
            "2025-03-10": WorkoutSummary(totalTime: 75, totalSets: 8, totalReps: 100, totalWeight: 400, totalExercises: 4),
            "2025-03-11": WorkoutSummary(totalTime: 60, totalSets: 6, totalReps: 80, totalWeight: 300, totalExercises: 3)
        ]
        // For preview, pass a fixed date for currentMonday.
        WorkoutSummaryView(data: dummyData, currentMonday: Date())
    }
}
