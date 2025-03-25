import Foundation

struct SearchMuscleGroupsDto: Codable {
    var id: UUID?
    var orderBy: String?
    var orderDirection: String = "asc"
    var pageSize: Int = 10
    var pageIndex: Int = 0
    var i18NCode: String?

}
