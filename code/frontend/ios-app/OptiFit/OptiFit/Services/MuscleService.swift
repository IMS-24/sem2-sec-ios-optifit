import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

extension MuscleService: MuscleServiceProtocol {}
@MainActor
class MuscleService: ObservableObject {
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

    func searchMuscles(searchModel: Components.Schemas.SearchMuscleDto) async throws -> Components.Schemas.PaginatedResultOfGetMuscleDto {
        let result = try await client.Muscle_SearchMuscles(.init(body: .json(searchModel)))
        return try result.ok.body.json
    }
}
