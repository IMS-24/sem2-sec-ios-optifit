import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    @StateObject private var userProfileViewModel = UserProfileViewModel()
    @StateObject private var workoutViewModel = WorkoutViewModel()

    // Aggregates workout summaries by complete day ("yyyy-MM-dd").
    private var aggregatedSummaries: [String: Components.Schemas.WorkoutSummary] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var result: [String: Components.Schemas.WorkoutSummary] = [:]

        for workout in workoutViewModel.workouts {
            let dayKey = formatter.string(from: workout.startAtUtc!)
            if let summary = workout.workoutSummary {
                if let existing = result[dayKey] {
                    result[dayKey] = Components.Schemas.WorkoutSummary(
                        totalTime: existing.totalTime ?? 0 + Double(summary.totalTime ?? 0),
                        totalSets: Int32(existing.totalSets ?? 0) + Int32(summary.totalSets ?? 0),
                        totalReps: Int32(existing.totalReps ?? 0) + Int32(summary.totalReps ?? 0),
                        totalWeight: Double(existing.totalWeight ?? 0) + Double(summary.totalWeight ?? 0),
                        totalExercises: Int32(existing.totalExercises ?? 0) + Int32(summary.totalExercises ?? 0)
                    )
                } else {
                    result[dayKey] = summary
                }
            }
        }
        return result
    }

    /// State variable to store the Monday date for the selected week.
    @State private var currentMonday: Date = Date()
    /// 0 = current week, negative values = previous weeks.
    @State private var weekOffset: Int = 0

    /// Recalculate the week’s search parameters based on weekOffset.
    private func updateWeek() {
        let calendar = Calendar.current
        let now = Date()
        // Calculate current week's Monday.
        let weekOfYear = calendar.component(.weekOfYear, from: now)
        let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: now)
        let currentWeekMonday = calendar.date(
            from: DateComponents(
                weekday: 2,  // Monday
                weekOfYear: weekOfYear,
                yearForWeekOfYear: yearForWeekOfYear))!
        // Adjust Monday based on weekOffset.
        let monday = calendar.date(byAdding: .weekOfYear, value: weekOffset, to: currentWeekMonday)!
        currentMonday = monday  // Save for passing to WorkoutSummaryView.
        let sunday = calendar.date(byAdding: .day, value: 6, to: monday)!

        var searchModel = Components.Schemas.SearchWorkoutDto()
        searchModel.from = monday
        searchModel.to = sunday

        workoutViewModel.updateSearchModel(searchModel)
        Task {
            await workoutViewModel.searchWorkouts()
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    HeaderView()
                        .padding()
                        .background(Color(.secondaryBackground))
                        .cornerRadius(10)

                    // Pass aggregated summaries and currentMonday to WorkoutSummaryView.
                    WorkoutSummaryView(data: aggregatedSummaries, currentMonday: currentMonday)
                        .padding()
                        .background(Color(.secondaryBackground))
                        .cornerRadius(10)

//                    QuickActionsView()
//                        .padding()
//                        .background(Color("SecondaryBackground"))
//                        .cornerRadius(10)
                }
                .padding()
                .gesture(
                    DragGesture(minimumDistance: 30)
                        .onEnded { value in
                            if abs(value.translation.width) > abs(value.translation.height) {
                                if value.translation.width > 0 {
                                    // Left swipe: previous week.
                                    weekOffset -= 1
                                } else if value.translation.width < 0 {
                                    // Right swipe: move toward current week, but not beyond.
                                    if weekOffset < 0 {
                                        weekOffset += 1
                                    }
                                }
                            }
                        }
                )
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Set the navigation bar title color with a custom view
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.headline)
                        .foregroundColor(Color(.primaryText))
                }
            }
        }
        .accentColor(Color(.primaryAccent))
        .onAppear {
            Task {
                await userProfileViewModel.loadStats()
                updateWeek()
            }
        }
        .onChange(of: weekOffset) {
            updateWeek()
        }
        .alert(item: $userProfileViewModel.errorMessage) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HomeView()
}
