import Foundation

struct PaginatedResult<T: Codable>: Codable {
    let items: [T]
    let pageIndex: Int
    let pageSize: Int
    let totalCount: Int
    let totalPages: Int
    let hasPreviousPage: Bool
    let hasNextPage: Bool
}
