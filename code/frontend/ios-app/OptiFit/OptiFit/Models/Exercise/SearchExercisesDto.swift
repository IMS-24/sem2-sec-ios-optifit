import Foundation

struct SearchExercisesDto: Codable {
    var i18NCode: UUID?
    var description: String?
    var exerciseTypeId: UUID?
    var pageSize: Int = 10
    var pageIndex: Int = 0
    var orderBy: String?
    var orderDirection: String = "asc"
    var id: UUID?
}
