import Foundation

struct SearchWorkoutsDto: Codable {
    var pageSize: Int = 100
    var pageIndex: Int = 0
    var orderBy: String?
    var orderDirection: String = "asc"
    var id: UUID?
    var from:Date?
    var to:Date?
}
