import SwiftUI

final class MockGymService: GymServiceProtocol, @unchecked Sendable {
    func searchGym(searchModel: Components.Schemas.SearchGymsDto) async throws -> Components.Schemas.PaginatedResultOfGetGymDto {
        guard let url = Bundle.main.url(forResource: "MockGyms", withExtension: "json") else {
            throw NSError(domain: "MockGymService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockGyms.json file not found"])
        }
        let data = try Data(contentsOf: url)
        print("[DEBUG] - Raw Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.PaginatedResultOfGetGymDto.self, from: data)
        return result
    }
}
