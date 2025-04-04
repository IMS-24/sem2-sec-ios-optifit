import SwiftUI

final class MockWorkoutService: WorkoutServiceProtocol, @unchecked Sendable {
    func searchWorkouts(searchModel: Components.Schemas.SearchWorkoutDto) async throws -> Components.Schemas.PaginatedResultOfGetWorkoutDto {
        guard let url = Bundle.main.url(forResource: "MockWorkouts", withExtension: "json") else {
            throw NSError(domain: "MockWorkoutService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockWorkouts.json file not found"])
        }
        let data = try Data(contentsOf: url)
        print("[DEBUG] - Raw Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.PaginatedResultOfGetWorkoutDto.self, from: data)
        return result
    }

    func postWorkout(_ workout: Components.Schemas.CreateWorkoutDto) async throws -> Components.Schemas.GetWorkoutDto {
        guard let url = Bundle.main.url(forResource: "MockWorkoutPost", withExtension: "json") else {
            throw NSError(domain: "MockWorkoutService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockWorkoutPost.json file not found"])
        }
        let data = try Data(contentsOf: url)
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.GetWorkoutDto.self, from: data)
        return result
    }
}
