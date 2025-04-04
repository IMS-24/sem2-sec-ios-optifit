protocol GymServiceProtocol: Sendable{
    func searchGym(searchModel: Components.Schemas.SearchGymsDto) async throws -> Components.Schemas.PaginatedResultOfGetGymDto
}
