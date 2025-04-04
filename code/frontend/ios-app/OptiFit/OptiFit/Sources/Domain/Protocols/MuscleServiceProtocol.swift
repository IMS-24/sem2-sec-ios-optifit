protocol MuscleServiceProtocol: Sendable {
    func searchMuscles(searchModel: Components.Schemas.SearchMuscleDto) async throws -> Components.Schemas.PaginatedResultOfGetMuscleDto
}
