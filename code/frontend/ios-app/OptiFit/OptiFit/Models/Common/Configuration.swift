import Foundation

enum Configuration {
    static var apiBaseURL: URL {
        URL(string: string(for: "API_BASE_URL"))!
    }

    static private func string(for key: String) -> String {
        return Bundle.main.infoDictionary?[key] as! String
    }
}
