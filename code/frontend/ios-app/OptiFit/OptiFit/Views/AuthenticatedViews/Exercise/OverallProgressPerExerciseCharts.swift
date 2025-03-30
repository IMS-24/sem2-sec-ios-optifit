import Charts
import SwiftUI

struct OverallProgressPerExerciseCharts: View {
    let workoutExercises: [Components.Schemas.ExerciseWorkoutDto]

    // Flatten all workout sets from all sessions into a single array.
    var allData: [SetProgressData] {
        let data = workoutExercises.flatMap { exercise -> [SetProgressData] in
            // Use nil-coalescing to safely unwrap workoutSets.
            let sets = exercise.workoutSets ?? []
            return sets.map { set in
                // Force unwrapping is kept as in your code, but consider safer unwrapping in production.
                SetProgressData(
                    setOrder: Int(set.order ?? 0),
                    date: exercise.workout!.startAtUtc!,
                    weight: Double(set.weight ?? 0),
                    reps: Int(set.reps ?? 0)
                )
            }
        }
        return data.sorted { $0.date < $1.date }
    }



    // Unique set orders (each will represent a separate line).
    var setOrders: [Int] {
        let orders = Set(allData.map { $0.setOrder })
        return orders.sorted()
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
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Weight", point.weight)
                            )
                            .foregroundStyle(by: .value("order", String(order)))
                            PointMark(
                                x: .value("Date", point.date),
                                y: .value("Weight", point.weight)
                            )
                            .foregroundStyle(by: .value("order", String(order)))
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
//                .chartYAxis {
//                    AxisMarks(position: .leading)
//                }
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
                            .foregroundStyle(by: .value("order", String(order)))
                            PointMark(
                                x: .value("Date", point.date),
                                y: .value("Total Weight", point.totalWeight)
                            )
                            .foregroundStyle(by: .value("order", String(order)))
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
                            .foregroundStyle(by: .value("order", String(order)))
                            PointMark(
                                x: .value("Date", point.date),
                                y: .value("Reps", point.reps)
                            )
                            .foregroundStyle(by: .value("order", String(order)))
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
            Components.Schemas.ExerciseWorkoutDto(
                id: UUID().uuidString,
                order: 1,
                workout: Components.Schemas.GetWorkoutDto(
                    id: UUID().uuidString,
                    description: "Workout 1",
                    startAtUtc: Date().addingTimeInterval(-86400 * 3),
                    endAtUtc: Date().addingTimeInterval(-86400 * 3 + 3600),
                    notes: "Notes 1",
                    gymId: UUID().uuidString,
                    gym: Components.Schemas.GetGymDto(id: UUID().uuidString, name: "Gym 1", address: "Address", city: "City", zipCode: 12345),
                    workoutExercises: [],
                    workoutSummary: Components.Schemas.WorkoutSummary(totalTime: 60, totalSets: 2, totalReps: 25, totalWeight: 250, totalExercises: 1)
                ),
                exerciseId: UUID().uuidString,
                workoutSets: [
                    Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 1, reps: 10, weight: 100, workoutExerciseId: UUID().uuidString),
                    Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 2, reps: 15, weight: 90, workoutExerciseId: UUID().uuidString),
                ],
                notes: "Workout 1 notes"
            ),
            Components.Schemas.ExerciseWorkoutDto(
                id: UUID().uuidString,
                order: 2,
                workout: Components.Schemas.GetWorkoutDto(
                    id: UUID().uuidString,
                    description: "Workout 2",
                    startAtUtc: Date().addingTimeInterval(-86400 * 2),
                    endAtUtc: Date().addingTimeInterval(-86400 * 2 + 3600),
                    notes: "Notes 2",
                    gymId: UUID().uuidString,
                    gym: Components.Schemas.GetGymDto(id: UUID().uuidString, name: "Gym 1", address: "Address", city: "City", zipCode: 12345),
                    workoutExercises: [],
                    workoutSummary: Components.Schemas.WorkoutSummary(totalTime: 60, totalSets: 3, totalReps: 40, totalWeight: 350, totalExercises: 1)
                ),
                exerciseId: UUID().uuidString,
                workoutSets: [
                    Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 1, reps: 12, weight: 105, workoutExerciseId: UUID().uuidString),
                    Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 2, reps: 14, weight: 95, workoutExerciseId: UUID().uuidString),
                    Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 3, reps: 10, weight: 110, workoutExerciseId: UUID().uuidString),
                ],
                notes: "Workout 2 notes"
            ),
            Components.Schemas.ExerciseWorkoutDto(
                id: UUID().uuidString,
                order: 3,
                workout: Components.Schemas.GetWorkoutDto(
                    id: UUID().uuidString,
                    description: "Workout 3",
                    startAtUtc: Date().addingTimeInterval(-86400),
                    endAtUtc: Date().addingTimeInterval(-86400 + 3600),
                    notes: "Notes 3",
                    gymId: UUID().uuidString,
                    gym: Components.Schemas.GetGymDto(id: UUID().uuidString, name: "Gym 1", address: "Address", city: "City", zipCode: 12345),
                    workoutExercises: [],
                    workoutSummary: Components.Schemas.WorkoutSummary(totalTime: 60, totalSets: 2, totalReps: 30, totalWeight: 280, totalExercises: 1)
                ),
                exerciseId: UUID().uuidString,
                workoutSets: [
                    Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 1, reps: 11, weight: 102, workoutExerciseId: UUID().uuidString),
                    Components.Schemas.GetWorkoutSetDto(id: UUID().uuidString, order: 3, reps: 9, weight: 108, workoutExerciseId: UUID().uuidString),
                ],
                notes: "Workout 3 notes"
            ),
        ]
    )
}
