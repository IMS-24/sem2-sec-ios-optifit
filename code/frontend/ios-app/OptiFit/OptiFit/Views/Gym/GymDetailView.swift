//
//  GymDetailView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import SwiftUI

struct GymDetailView: View {
    let gym: Gym

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(gym.name)
                    .font(.largeTitle)
                    .bold()

            Text(gym.address)
                    .font(.title3)

            Text("City: \(gym.city)")
            Text("ZIP Code: \(String(gym.zipCode))")

            Spacer()
        }
                .padding()
                .navigationTitle("Gym Details")
    }
}

#Preview {
    GymDetailView(
            gym: Gym(
                    address: "Daham",
                    zipCode: 8020,
                    id: UUID(),
                    name: "Home Gym",
                    city: "Graz"
            )
    )
}
