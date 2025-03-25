import SwiftUI

struct GymManagementView: View {
    @StateObject private var gymViewModel = GymViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedGyms.keys.sorted(by: { $0.city < $1.city }), id: \.self) { key in
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
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }

    // Grouping gyms by city and zip code
    private var groupedGyms: [CityZip: [GetGymDto]] {
        Dictionary(grouping: gymViewModel.gyms, by: { CityZip(city: $0.city, zipCode: $0.zipCode) })
    }

}

#Preview {
    GymManagementView()
}
