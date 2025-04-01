import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI


@MainActor
class GymService: ObservableObject {
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

    func searchGym(searchModel: Components.Schemas.SearchGymsDto) async throws -> Components.Schemas.PaginatedResultOfGetGymDto {
        let result = try await client.Gym_SearchGyms(.init(body: .json(searchModel)))
        return try result.ok.body.json
    }

}
