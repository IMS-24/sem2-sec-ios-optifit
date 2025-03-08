

import Foundation


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
