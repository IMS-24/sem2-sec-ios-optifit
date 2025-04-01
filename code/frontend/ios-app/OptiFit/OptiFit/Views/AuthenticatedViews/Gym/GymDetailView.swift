import SwiftUI

struct GymDetailView: View {
    let gym: Components.Schemas.GetGymDto

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(gym.name!)
                .font(.largeTitle)
                .bold()

            Text(gym.address!)
                .font(.title3)

            Text("City: \(gym.city)")
            Text("ZIP Code: \(String(gym.zipCode!))")

            Spacer()
        }
        .padding()
        .navigationTitle("Gym Details")
    }
}

#Preview {
    GymDetailView(
        gym: Components.Schemas.GetGymDto(
            id: UUID().uuidString, name: "Home Gym", address: "Daham", city: "Graz", zipCode: 8020
        )
    )
}
