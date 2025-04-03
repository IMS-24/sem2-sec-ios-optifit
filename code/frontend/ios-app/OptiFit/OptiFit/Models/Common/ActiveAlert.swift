enum ActiveAlert: Identifiable {
    case cancel, error(String)
    
    var id: String {
        switch self {
        case .cancel:
            return "cancel"
        case .error(let message):
            return "error-\(message)"
        }
    }
}
