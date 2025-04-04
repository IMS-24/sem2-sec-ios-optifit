import Charts
import SwiftUI

struct OverallProgressPerExerciseCharts: View {
    let workoutExercises: [Components.Schemas.ExerciseWorkoutDto]

    // Aggregate all sets from all exercises into a single array.
    var allData: [SetProgressData] {
        let data = workoutExercises.flatMap { exercise -> [SetProgressData] in
            let sets = exercise.workoutSets ?? []
            return sets.map { set in
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

    // Compute the unique dates with data.
    var allDates: [Date] {
        let dates = Set(allData.map { $0.date })
        return dates.sorted()
    }

    // Unique set orders.
    var setOrders: [Int] {
        let orders = Set(allData.map { $0.setOrder })
        return orders.sorted()
    }

    // MARK: - Chart Views

    var weightChart: some View {
        VStack(alignment: .leading) {
            Text("Weight Progress")
                .font(.headline)
            Chart {
                weightChartContent(setOrders: setOrders, allData: allData)
            }
            .chartXAxis {
                AxisMarks(values: allDates) { value in
                    if let date = value.as(Date.self) {
                        AxisValueLabel {
                            Text(DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none))
                                .rotationEffect(.degrees(45))
                                .fixedSize()
                        }
                    }
                }
            }
            .chartPlotStyle { plot in
                // Increase the bottom padding to allow more room for rotated labels.
                plot.padding(.bottom, 50)
            }
            // Optionally, set a wider frame.
            .frame(height: 200)
        }
        .padding()
    }



    var totalWeightChart: some View {
        VStack(alignment: .leading) {
            Text("Total Weight (Volume) Progress")
                .font(.headline)
            Chart {
                totalWeightChartContent(setOrders: setOrders, allData: allData)
            }
            .chartXAxis {
                AxisMarks(values: allDates) { value in
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
        .padding()
    }

    var repsChart: some View {
        VStack(alignment: .leading) {
            Text("Reps Progress")
                .font(.headline)
            Chart {
                repsChartContent(setOrders: setOrders, allData: allData)
            }
            .chartXAxis {
                AxisMarks(values: allDates) { value in
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
        .padding()
    }

    var body: some View {
        TabView {
            weightChart
            totalWeightChart
            repsChart
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .padding()
    }
}
