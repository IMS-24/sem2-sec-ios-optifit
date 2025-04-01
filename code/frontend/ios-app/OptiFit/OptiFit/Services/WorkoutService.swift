import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

@MainActor
class WorkoutService: ObservableObject {
    var baseUrl = AppConfiguration.apiBaseURL
    let configuration = Configuration(
        dateTranscoder: DotNetDateTranscoder()
    )
    let client: Client

    init() {
        client = Client(
            serverURL: baseUrl,
            configuration: configuration,
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware()]
        )
    }

    func searchWorkouts(searchModel: Components.Schemas.SearchWorkoutDto) async throws -> Components.Schemas.PaginatedResultOfGetWorkoutDto {
        let result = try await client.Workout_SearchWorkouts(.init(body: .json(searchModel)))
        return try result.ok.body.json
    }

    func postWorkout(_ workout: Components.Schemas.CreateWorkoutDto) async throws -> Components.Schemas.GetWorkoutDto {
        let result = try await client.Workout_CreateWorkout(.init(body: .json(workout)))
        return try result.ok.body.json
    }
}
