//
//  ActivityGraphView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI
import Charts

struct ActivityGraphView: View {
    var data: [WorkoutStat]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Weekly Activity")
                    .font(.headline)
                    .padding(.leading)

            Chart(data) { stat in
                BarMark(
                        x: .value("Day", stat.day),
                        y: .value("Workouts", stat.workoutMinutes)
                )
                        .foregroundStyle(.blue)
            }
                    .frame(height: 200)
                    .padding()
        }
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.horizontal)
    }
}

#Preview {
    ActivityGraphView(data: [])
}
