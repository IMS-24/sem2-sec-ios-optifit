import Combine
import Foundation

@MainActor
class MuscleGroupViewModel: ObservableObject {
    @Published var muscleGroups: [Components.Schemas.GetMuscleGroupDto] = []
    @Published var errorMessage: ErrorMessage?

    private var searchModel = Components.Schemas.SearchMuscleGroupDto()

    private let muscleGroupService = MuscleGroupService()

    private var currentPage: Int = 0
    private var totalPages: Int = 1
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false

    func searchMuscleGroups() async {
        isLoading = true
        errorMessage = nil
        do {
            currentPage = 0
            let result = try await muscleGroupService.searchMuscleGroups(searchModel: searchModel)
            muscleGroups = result.items ?? []
            totalPages = (Int)(result.totalPages ?? 1)
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func updateSearchModel(_ newModel: Components.Schemas.SearchMuscleGroupDto) async {
        self.searchModel = newModel

    }
}
