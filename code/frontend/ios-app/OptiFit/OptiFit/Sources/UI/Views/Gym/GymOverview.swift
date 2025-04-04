import SwiftUI

struct GymOverview: View {
    let gym: Components.Schemas.GetGymDto

    var body: some View {
        VStack(alignment: .leading) {
            Text(gym.name!)
                .font(.headline)
            Text(gym.address!)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    GymOverview(
        gym: Components.Schemas.GetGymDto(
            id: UUID().uuidString, name: "Special Gym", address: "Strasse", city: "Cityy", zipCode: 8020
        )
    )
}
