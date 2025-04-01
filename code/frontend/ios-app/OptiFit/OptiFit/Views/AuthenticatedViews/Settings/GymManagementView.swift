import SwiftUI
struct GymManagementView: View {
    @StateObject private var gymViewModel = GymViewModel()
    
    var body: some View {
        NavigationView {
            List {
                // Use the pre-computed sorted cities.
                ForEach(sortedCities, id: \.zipCode) { key in
                    CityGymGroup(cityZip: key, gyms: groupedGyms[key] ?? [])
                }
            }
            .navigationTitle("Gyms")
            .onAppear {
                Task {
                    await gymViewModel.searchGyms()
                }
            }
            .toolbar {
                EditButton()
            }
            .alert(item: $gymViewModel.errorMessage) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // Group gyms by city and zip code.
    private var groupedGyms: [CityZip: [Components.Schemas.GetGymDto]] {
        Dictionary(grouping: gymViewModel.gyms) { gym in
            // Assuming `gym.city` and `gym.zipCode` are non-optional.
            CityZip(city: gym.city!, zipCode: String(gym.zipCode!))
        }
    }
    
    // Pre-compute sorted keys to simplify the ForEach expression.
    private var sortedCities: [CityZip] {
        groupedGyms.keys.sorted { (lhs: CityZip, rhs: CityZip) -> Bool in
            lhs.city < rhs.city
        }
    }
}



#Preview {
    GymManagementView()
}
