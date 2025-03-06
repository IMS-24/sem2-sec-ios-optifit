//
//  SearchGymDto.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 22.02.25.
//

import Foundation

// Define a Swift model for the search parameters.
// Adjust the default values as needed.
struct SearchGymsDto: Codable {
    var id: UUID?
    var orderBy: String?
    var orderDirection: String = "asc"
    var pageSize: Int = 10
    var pageIndex: Int = 0
    var name: String?
    var address: String?
    var city: String?
    var zipCode: Int?
}
