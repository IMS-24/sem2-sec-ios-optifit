import SwiftUI

final class MockMuscleService: MuscleServiceProtocol, @unchecked Sendable {
    func searchMuscles(searchModel: Components.Schemas.SearchMuscleDto) async throws -> Components.Schemas.PaginatedResultOfGetMuscleDto {
        guard let url = Bundle.main.url(forResource: "MockMuscles", withExtension: "json") else {
            throw NSError(domain: "MockMuscleService", code: 404, userInfo: [NSLocalizedDescriptionKey: "MockMuscles.json file not found"])
        }
        let data = try Data(contentsOf: url)
        print("[DEBUG] - Raw Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
        let result = try ISO8601CustomCoder.makeDecoder().decode(Components.Schemas.PaginatedResultOfGetMuscleDto.self, from: data)
        return result
    }
}
