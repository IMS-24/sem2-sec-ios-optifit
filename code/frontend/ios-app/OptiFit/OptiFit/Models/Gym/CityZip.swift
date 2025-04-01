struct CityZip: Hashable, Identifiable {
    let city: String
    let zipCode: String
    var id: String { zipCode }
}
