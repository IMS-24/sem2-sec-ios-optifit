import Foundation

enum Configuration {
    static private func string(for key: String) -> String {
        return Bundle.main.infoDictionary?[key] as! String
    }

    static var apiBaseURL: URL {
        URL(string: string(for: "API_BASE_URL"))!
    }

    static var b2cClientId: String {
        string(for: "B2C_CLIENT_ID")
    }

    static var b2cTenantId: String {
        string(for: "B2C_TENANT")
    }

    static var b2cPolicyId: String {
        string(for: "B2C_POLICY")
    }

    static var b2cAuthority: String {
        string(for: "B2C_AUTHORITY")
    }

    static var b2cScopes: [String] {
        string(for: "B2C_SCOPES").split(separator: ",").map(String.init)
    }
}
