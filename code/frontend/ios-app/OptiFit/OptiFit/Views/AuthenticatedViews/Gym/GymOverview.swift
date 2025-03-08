//
//  GymOverview.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import SwiftUI

// MARK: - **GymOverview Subview**
struct GymOverview: View {
    let gym: GetGymDto

    var body: some View {
        VStack(alignment: .leading) {
            Text(gym.name)
                    .font(.headline)
            Text(gym.address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
        }
    }
}

#Preview {
    GymOverview(
            gym: GetGymDto(
                    address: "Strasse",
                    zipCode: 8020,
                    id: UUID(),
                    name: "Special Gym",
                    city: "Cityy"
            )
    )
}
