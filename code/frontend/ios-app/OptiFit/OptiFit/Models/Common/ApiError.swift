//
//  ApiError.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

enum ApiError: Error {
    case invalidURL
    case badRequest(String?)
    case unauthorized(String?)
    case serverError(String?)
    case requestFailed
    case decodingFailed
    case unknown
}
