import Foundation

enum AppConfiguration {
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

    static var appName: String {
        string(for: "APP_NAME")
    }

    static var gitHash: String {
        string(for: "GIT_HASH")
    }

    static var Environment: String {
        #if STAGING
            return "STAGE"
        #elseif PRODUCTION
            return "PROD"
        #elseif TESTING
            return "QA"
        #elseif DEVELOPMENT
            return "DEV"
        #endif
    }

    static var fullSemVersion: String {
        string(for: "FULL_SEMVER")
    }

    static var gitBranch: String {
        string(for: "GIT_BRANCH")
    }

}
