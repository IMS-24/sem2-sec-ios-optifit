//
//  QuickActionsView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct QuickActionsView: View {
    var body: some View {
        HStack(spacing: 20) {
            Button("Start Workout", systemImage: "play.fill") {
                print("Start Workout tapped")
            }
            Button("View Exercises", systemImage: "list.bullet.rectangle") {
                print("View Exercises tapped")
            }
        }
                .padding()
    }
}

#Preview {
    QuickActionsView()
}
