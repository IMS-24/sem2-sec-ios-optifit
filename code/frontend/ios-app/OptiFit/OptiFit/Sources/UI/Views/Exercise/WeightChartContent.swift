import Charts
import SwiftUI

@ChartContentBuilder
func weightChartContent(setOrders: [Int], allData: [SetProgressData]) -> some ChartContent {
    ForEach(setOrders, id: \.self) { order in
        let series = allData.filter { $0.setOrder == order }
            .sorted { $0.date < $1.date }
        ForEach(series, id: \.id) { point in
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

@ChartContentBuilder
func totalWeightChartContent(setOrders: [Int], allData: [SetProgressData]) -> some ChartContent {
    ForEach(setOrders, id: \.self) { order in
        let series = allData.filter { $0.setOrder == order }
            .sorted { $0.date < $1.date }
        ForEach(series, id: \.id) { point in
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

@ChartContentBuilder
func repsChartContent(setOrders: [Int], allData: [SetProgressData]) -> some ChartContent {
    ForEach(setOrders, id: \.self) { order in
        let series = allData.filter { $0.setOrder == order }
            .sorted { $0.date < $1.date }
        ForEach(series, id: \.id) { point in
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
