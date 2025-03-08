


import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()

    /// Saves a token to the Keychain.
    func save(token: String, service: String, account: String) -> Bool {
        guard let tokenData = token.data(using: .utf8) else {
            return false
        }
        
        // Define the query for adding the token.
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: tokenData,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        // Delete any existing item before adding a new one.
        SecItemDelete(query as CFDictionary)
        
        // Add the new token to the Keychain.
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    /// Retrieves a token from the Keychain.
    func readToken(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let tokenData = dataTypeRef as? Data {
            return String(data: tokenData, encoding: .utf8)
        }
        return nil
    }

    /// Deletes a token from the Keychain.
    func deleteToken(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
        ]
        SecItemDelete(query as CFDictionary)
    }
}
