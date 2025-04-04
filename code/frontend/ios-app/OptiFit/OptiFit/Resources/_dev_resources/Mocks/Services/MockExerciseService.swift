
import Foundation
import SwiftUI

final class MockExerciseService: ExerciseServiceProtocol, @unchecked Sendable {
    
    func fetchExerciseCategories() async throws -> [Components.Schemas.GetExerciseCategoryDto] {
        guard let url = Bundle.main.url(forResource: "MockExerciseCategories", withExtension: "json") else {
            throw NSError(domain: "MockExerciseService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockExerciseCategories.json file not found"])
        }
        let data = try Data(contentsOf: url)
        let result = try ISO8601CustomCoder.makeDecoder().decode([Components.Schemas.GetExerciseCategoryDto].self, from: data)
        return result
    }
    
    func fetchExerciseStatistics(exerciseId: UUID) async throws -> Components.Schemas.GetExerciseStatisticsDto {
        guard let url = Bundle.main.url(forResource: "MockExerciseStatistics", withExtension: "json") else {
            throw NSError(domain: "MockExerciseService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockExerciseStatistics.json file not found"])
        }
        let data = try Data(contentsOf: url)
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.GetExerciseStatisticsDto.self, from: data)
        return result
    }
    
    func searchExercises(searchModel: Components.Schemas.SearchExerciseDto) async throws -> Components.Schemas.PaginatedResultOfGetExerciseDto {
        guard let url = Bundle.main.url(forResource: "MockSearchExercises", withExtension: "json") else {
            throw NSError(domain: "MockExerciseService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockSearchExercises.json file not found"])
        }
        let data = try Data(contentsOf: url)
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.PaginatedResultOfGetExerciseDto.self, from: data)
        return result
    }
    
    func postExercise(_ exercise: Components.Schemas.CreateExerciseDto) async throws -> Components.Schemas.GetExerciseDto {
        guard let url = Bundle.main.url(forResource: "MockExercisePost", withExtension: "json") else {
            throw NSError(domain: "MockExerciseService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockExercisePost.json file not found"])
        }
        let data = try Data(contentsOf: url)
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.GetExerciseDto.self, from: data)
        return result
    }
    
    func updateExercise(exerciseId: UUID, exercise: Components.Schemas.UpdateExerciseDto) async throws -> Components.Schemas.GetExerciseDto {
        guard let url = Bundle.main.url(forResource: "MockExerciseUpdate", withExtension: "json") else {
            throw NSError(domain: "MockExerciseService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockExerciseUpdate.json file not found"])
        }
        let data = try Data(contentsOf: url)
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.GetExerciseDto.self, from: data)
        return result
    }
    
    func deleteExercise(exerciseId: UUID) async throws -> UUID {
        // For deletion, simply return the provided exerciseId to simulate success.
        return exerciseId
    }
}
