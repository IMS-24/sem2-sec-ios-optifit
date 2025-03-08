import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    @StateObject private var userProfileViewModel = UserProfileViewModel()
    @StateObject private var workoutViewModel = WorkoutViewModel()
    
    // Aggregates workout summaries by complete day ("yyyy-MM-dd").
    private var aggregatedSummaries: [String: WorkoutSummary] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var result: [String: WorkoutSummary] = [:]
        
        for workout in workoutViewModel.workouts {
            let dayKey = formatter.string(from: workout.startAtUtc)
            if let summary = workout.workoutSummary
            {
                if let existing = result[dayKey] {
                    result[dayKey] = WorkoutSummary(
                        totalTime: existing.totalTime + summary.totalTime,
                        totalSets: existing.totalSets + summary.totalSets,
                        totalReps: existing.totalReps + summary.totalReps,
                        totalWeight: existing.totalWeight + summary.totalWeight,
                        totalExercises: existing.totalExercises + summary.totalExercises
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
        let currentWeekMonday = calendar.date(from: DateComponents(
            weekday: 2, // Monday
            weekOfYear: weekOfYear,
            yearForWeekOfYear: yearForWeekOfYear))!
        // Adjust Monday based on weekOffset.
        let monday = calendar.date(byAdding: .weekOfYear, value: weekOffset, to: currentWeekMonday)!
        currentMonday = monday  // Save for passing to WorkoutSummaryView.
        let sunday = calendar.date(byAdding: .day, value: 6, to: monday)!
        
        var searchModel = SearchWorkoutsDto()
        searchModel.from = monday
        searchModel.to = sunday
        
        workoutViewModel.updateSearchModel(searchModel)
        Task {
            await workoutViewModel.searchWorkouts(token: viewModel.accessToken!)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    HeaderView()
                        .padding()
                        .background(Color("SecondaryBackground"))
                        .cornerRadius(10)
                    
                    // Pass aggregated summaries and currentMonday to WorkoutSummaryView.
                    WorkoutSummaryView(data: aggregatedSummaries, currentMonday: currentMonday)
                        .padding()
                        .background(Color("SecondaryBackground"))
                        .cornerRadius(10)
                    
                    QuickActionsView()
                        .padding()
                        .background(Color("SecondaryBackground"))
                        .cornerRadius(10)
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
            
           // .background(Color("PrimaryBackground").ignoresSafeArea())
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Set the navigation bar title color with a custom view
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.headline)
                        .foregroundColor(Color("PrimaryText"))
                }
            }
        }
        .accentColor(Color("PrimaryAccent"))
        .onAppear {
            Task {
                await userProfileViewModel.loadStats(token: viewModel.accessToken!)
                updateWeek()
            }
        }
        .onChange(of: weekOffset) {
            updateWeek()
        }
        .alert(item: $userProfileViewModel.errorMessage) { error in
            Alert(title: Text("Error"),
                  message: Text(error.message),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HomeView()
}
