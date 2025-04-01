import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

@MainActor
class MuscleGroupService: ObservableObject {
    var baseUrl = AppConfiguration.apiBaseURL
    let configuration = Configuration()
    let client: Client

    init() {
        client = Client(
            serverURL: baseUrl,
            configuration: configuration,
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware()]
        )
    }
    func searchMuscleGroups(searchModel: Components.Schemas.SearchMuscleGroupDto) async throws -> Components.Schemas.PaginatedResultOfGetMuscleGroupDto {
        let result = try await client.MuscleGroup_SearchMuscleGroups(.init(body: .json(searchModel)))
        return try result.ok.body.json

    }
}
