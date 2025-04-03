enum ActiveAlert: Identifiable {
    case cancel, error(String)
    
    var id: Int {
        hashValue
    }
}
