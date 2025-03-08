
import Foundation

struct CreateWorkoutSetDto: Codable, Identifiable {
    var id: UUID?
    var order: Int?
    var reps: Int?
    var weight: Double?
}
