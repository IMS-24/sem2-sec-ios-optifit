//
//  ApiError.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

enum ApiServiceError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case unknown
}
