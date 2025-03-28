import Combine
import Foundation

@MainActor
class MuscleGroupViewModel: ObservableObject {
    @Published var muscleGroups: [GetMuscleGroupDto] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel = SearchMuscleGroupsDto(pageSize: 10, pageIndex: 0)
    @Published var isLoading: Bool = false
    private let muscleGroupService = MuscleGroupService()
    private var cancellables = Set<AnyCancellable>()

    func searchMuscleGroups() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await muscleGroupService.searchMuscleGroups(searchModel: searchModel)
            muscleGroups = response.items
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func updateSearchModel(_ newModel: SearchMuscleGroupsDto) async {
        self.searchModel = newModel

    }
}
