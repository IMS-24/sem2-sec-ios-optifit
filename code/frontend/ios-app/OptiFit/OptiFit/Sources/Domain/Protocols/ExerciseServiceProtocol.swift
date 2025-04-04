
import Foundation
import SwiftUI

protocol ExerciseServiceProtocol: Sendable{
    func fetchExerciseCategories() async throws -> [Components.Schemas.GetExerciseCategoryDto]
    func fetchExerciseStatistics(exerciseId: UUID) async throws -> Components.Schemas.GetExerciseStatisticsDto
    func searchExercises(searchModel: Components.Schemas.SearchExerciseDto) async throws -> Components.Schemas.PaginatedResultOfGetExerciseDto
    func postExercise(_ exercise: Components.Schemas.CreateExerciseDto) async throws -> Components.Schemas.GetExerciseDto
    func updateExercise(exerciseId: UUID, exercise: Components.Schemas.UpdateExerciseDto) async throws -> Components.Schemas.GetExerciseDto
    func deleteExercise(exerciseId: UUID) async throws -> UUID
}
