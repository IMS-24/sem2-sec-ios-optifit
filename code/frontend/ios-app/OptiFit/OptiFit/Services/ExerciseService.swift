import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

@MainActor
class ExerciseService: ObservableObject {
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
    func fetchExerciseCategories() async throws -> [Components.Schemas.GetExerciseCategoryDto] {
        let result = try await client.Exercise_GetExerciseCategories()
        return try result.ok.body.json
    }

    func fetchExerciseStatistics(exerciseId: UUID) async throws -> Components.Schemas.GetExerciseStatisticsDto {
        let result = try await client.Exercise_GetExerciseStats(
            .init(
                path: .init(id: exerciseId.uuidString)
            )
        )
        return try result.ok.body.json
    }

    func searchExercises(searchModel: Components.Schemas.SearchExerciseDto) async throws -> Components.Schemas.PaginatedResultOfGetExerciseDto {
        let result = try await client.Exercise_SearchExercises(.init(body: .json(searchModel)))
        return try result.ok.body.json
    }

    func postExercise(_ exercise: Components.Schemas.CreateExerciseDto) async throws -> Components.Schemas.GetExerciseDto {
        let result = try await client.Exercise_CreateExercise(.init(body: .json(exercise)))
        return try result.ok.body.json
    }

    func updateExercise(exerciseId: UUID, exercise: Components.Schemas.UpdateExerciseDto) async throws -> Components.Schemas.GetExerciseDto {
        let result = try await client.Exercise_UpdateExercise(
            .init(
                path: .init(id: exerciseId.uuidString),
                body: .json(exercise)
            )
        )
        return try result.ok.body.json

    }

    func deleteExercise(exerciseId: UUID) async throws -> UUID {
        let result = try await client.Exercise_DeleteExercise(.init(path: .init(id: exerciseId.uuidString)))
        return exerciseId
    }
}
