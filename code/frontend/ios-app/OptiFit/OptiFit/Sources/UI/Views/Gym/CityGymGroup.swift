import SwiftUI

struct CityGymGroup: View {
    let cityZip: CityZip
    let gyms: [Components.Schemas.GetGymDto]

    var body: some View {
        Section(header: Text("\(cityZip.city), \(String(cityZip.zipCode))")) {
            ForEach(gyms, id:\.id) { gym in
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
                cityZip: CityZip(city: "Graz", zipCode: "8020"),
                gyms: [
                    Components.Schemas.GetGymDto(
                        id: UUID().uuidString,
                        name: "Best Gym",
                        address: "Address 123",
                        city: "Graz",
                        zipCode: 8020
                    )
                ]
            )
        }
    }
}
