import SwiftUI
import Charts


struct OverallProgressPerExerciseCharts: View {
    let workoutExercises: [ExerciseWorkoutDto]
    
    // Flatten all workout sets from all sessions into a single array.
    var allData: [SetProgressData] {
        workoutExercises.flatMap { workout in
            workout.workoutSets.map { set in
                SetProgressData(
                    setOrder: set.order,
                    date: workout.workout.startAtUtc,
                    weight: set.weight,
                    reps: set.reps
                )
            }
        }
        .sorted(by: { $0.date < $1.date })
    }
    
    // Unique set orders (each will represent a separate line).
    var setOrders: [Int] {
        let orders = Set(allData.map { $0.setOrder })
        return orders.sorted()
    }
    
    /// Returns a distinct fixed color for a given set order.
    func color(for setOrder: Int) -> Color {
        switch setOrder {
        case 1:
            return .green
        case 2:
            return .red
        case 3:
            return .blue
        default:
            return .orange // fallback for any additional sets
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // MARK: Weight Chart
            VStack(alignment: .leading) {
                Text("Weight Progress")
                    .font(.headline)
                Chart {
                    ForEach(setOrders, id: \.self) { order in
                        let series = allData.filter { $0.setOrder == order }
                            .sorted(by: { $0.date < $1.date })
                        ForEach(series) { point in
                            let color = self.color(for: order)
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Weight", point.weight)
                            )
                            .foregroundStyle(color)
                            PointMark(
                                x: .value("Date", point.date),
                                y: .value("Weight", point.weight)
                            )
                            .foregroundStyle(color)
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic(desiredCount: 5)) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel(DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none))
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 200)
            }
            
            // MARK: Total Weight (Volume) Chart
            VStack(alignment: .leading) {
                Text("Total Weight (Volume) Progress")
                    .font(.headline)
                Chart {
                    ForEach(setOrders, id: \.self) { order in
                        let series = allData.filter { $0.setOrder == order }
                            .sorted(by: { $0.date < $1.date })
                        ForEach(series) { point in
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Total Weight", point.totalWeight)
                            )
                            .foregroundStyle(color(for: order))
                            PointMark(
                                x: .value("Date", point.date),
                                y: .value("Total Weight", point.totalWeight)
                            )
                            .foregroundStyle(color(for: order))
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic(desiredCount: 5)) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel(DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none))
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 200)
            }
            
            // MARK: Reps Chart
            VStack(alignment: .leading) {
                Text("Reps Progress")
                    .font(.headline)
                Chart {
                    ForEach(setOrders, id: \.self) { order in
                        let series = allData.filter { $0.setOrder == order }
                            .sorted(by: { $0.date < $1.date })
                        ForEach(series) { point in
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Reps", point.reps)
                            )
                            .foregroundStyle(color(for: order))
                            PointMark(
                                x: .value("Date", point.date),
                                y: .value("Reps", point.reps)
                            )
                            .foregroundStyle(color(for: order))
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic(desiredCount: 5)) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel(DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none))
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 200)
            }
        }
        .padding()
    }
}
#Preview {
    OverallProgressPerExerciseCharts(
        workoutExercises: [
            ExerciseWorkoutDto(
                id: UUID(),
                order: 1,
                workout: GetWorkoutDto(
                    id: UUID(),
                    description: "Workout 1",
                    startAtUtc: Date().addingTimeInterval(-86400 * 3),
                    endAtUtc: Date().addingTimeInterval(-86400 * 3 + 3600),
                    notes: "Notes 1",
                    gymId: UUID(),
                    gym: GetGymDto(address: "Address", zipCode: 12345, id: UUID(), name: "Gym 1", city: "City"),
                    workoutExercises: [],
                    workoutSummary: WorkoutSummary(totalTime: 60, totalSets: 2, totalReps: 25, totalWeight: 250, totalExercises: 1)
                ),
                exerciseId: UUID(),
                workoutSets: [
                    GetWorkoutSetDto(id: UUID(), order: 1, reps: 10, weight: 100, workoutExerciseId: UUID()),
                    GetWorkoutSetDto(id: UUID(), order: 2, reps: 15, weight: 90, workoutExerciseId: UUID())
                ],
                notes: "Workout 1 notes"
            ),
            ExerciseWorkoutDto(
                id: UUID(),
                order: 2,
                workout: GetWorkoutDto(
                    id: UUID(),
                    description: "Workout 2",
                    startAtUtc: Date().addingTimeInterval(-86400 * 2),
                    endAtUtc: Date().addingTimeInterval(-86400 * 2 + 3600),
                    notes: "Notes 2",
                    gymId: UUID(),
                    gym: GetGymDto(address: "Address", zipCode: 12345, id: UUID(), name: "Gym 1", city: "City"),
                    workoutExercises: [],
                    workoutSummary: WorkoutSummary(totalTime: 60, totalSets: 3, totalReps: 40, totalWeight: 350, totalExercises: 1)
                ),
                exerciseId: UUID(),
                workoutSets: [
                    GetWorkoutSetDto(id: UUID(), order: 1, reps: 12, weight: 105, workoutExerciseId: UUID()),
                    GetWorkoutSetDto(id: UUID(), order: 2, reps: 14, weight: 95, workoutExerciseId: UUID()),
                    GetWorkoutSetDto(id: UUID(), order: 3, reps: 10, weight: 110, workoutExerciseId: UUID())
                ],
                notes: "Workout 2 notes"
            ),
            ExerciseWorkoutDto(
                id: UUID(),
                order: 3,
                workout: GetWorkoutDto(
                    id: UUID(),
                    description: "Workout 3",
                    startAtUtc: Date().addingTimeInterval(-86400),
                    endAtUtc: Date().addingTimeInterval(-86400 + 3600),
                    notes: "Notes 3",
                    gymId: UUID(),
                    gym: GetGymDto(address: "Address", zipCode: 12345, id: UUID(), name: "Gym 1", city: "City"),
                    workoutExercises: [],
                    workoutSummary: WorkoutSummary(totalTime: 60, totalSets: 2, totalReps: 30, totalWeight: 280, totalExercises: 1)
                ),
                exerciseId: UUID(),
                workoutSets: [
                    GetWorkoutSetDto(id: UUID(), order: 1, reps: 11, weight: 102, workoutExerciseId: UUID()),
                    GetWorkoutSetDto(id: UUID(), order: 3, reps: 9, weight: 108, workoutExerciseId: UUID())
                ],
                notes: "Workout 3 notes"
            )
        ]
    )
}
