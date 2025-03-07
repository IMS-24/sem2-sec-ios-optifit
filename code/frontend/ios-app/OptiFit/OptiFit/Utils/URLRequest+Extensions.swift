//
//  Url+Extensions.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//
import Foundation
extension URLRequest {
    mutating func addAuthorizationHeader(with token: String?) {
        if let token = token {
            self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
