import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

@MainActor
class VirtualTrainerService: ObservableObject {
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

    func fetchMotivation(level: Int) async throws -> Components.Schemas.GetMotivationDto {
        let result = try await client.VirtualTrainer_GetMotivationalQuote(.init(path: .init(level: Int32(level))))
        print("Response : \(result)")
        return try result.ok.body.json

    }
}
