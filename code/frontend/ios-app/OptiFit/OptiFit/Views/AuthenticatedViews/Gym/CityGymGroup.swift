
import SwiftUI

struct CityGymGroup: View {
    let cityZip: CityZip
    let gyms: [GetGymDto]
    
    var body: some View {
        Section(header: Text("\(cityZip.city), \(String(cityZip.zipCode))")) {
            ForEach(gyms) { gym in
                NavigationLink(destination: GymDetailView(gym: gym)) {
                    GymOverview(gym: gym)
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
                        GetGymDto(
                                address: "Address 123",
                                zipCode: 8020,
                                id: UUID(),
                                name: "Best Gym",
                                city: "Graz"
                        )
                    ]
            )
        }
    }
}
