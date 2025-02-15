//
//  CityGymGroup.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import SwiftUI

// MARK: - **CityGymGroup Subview**
struct CityGymGroup: View {
    let cityZip: CityZip
    let gyms: [Gym]
    let onDelete: (Gym) -> Void

    var body: some View {
        Section(header: Text("\(cityZip.city), \(String(cityZip.zipCode))")) {
            ForEach(gyms) { gym in
                NavigationLink(destination: GymDetailView(gym: gym)) {
                    GymOverview(gym: gym)
                }
            }
                    .onDelete { indexSet in
                        indexSet.forEach {
                            onDelete(gyms[$0])
                        }
                    }
        }
    }
}

#Preview {
    NavigationView {
        List {
            CityGymGroup(
                    cityZip: CityZip(city: "Graz", zipCode: 8020),
                    gyms: [
                        Gym(
                                address: "Address 123",
                                zipCode: 8020,
                                id: UUID(),
                                name: "Best Gym",
                                city: "Graz"
                        )
                    ],
                    onDelete: { _ in print("Delete Gym") }
            )
        }
    }
}
