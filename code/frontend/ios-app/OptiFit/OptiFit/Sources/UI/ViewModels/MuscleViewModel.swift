import Combine
import Foundation

@MainActor
class MuscleViewModel: ObservableObject {
    @Published var muscles: [Components.Schemas.GetMuscleDto] = []
    @Published var errorMessage: ErrorMessage?

    private var searchModel: Components.Schemas.SearchMuscleDto = Components.Schemas.SearchMuscleDto()
    private let muscleService: MuscleServiceProtocol

    private var currentPage: Int = 0
    private var totalPages: Int = 1
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false

    init(muscleService: MuscleServiceProtocol = MuscleService()) {
        self.muscleService = muscleService
    }
    func searchMuscles() async {
        isLoading = true
        errorMessage = nil
        do {
            currentPage = 0
            searchModel.pageSize = 100
            let service = muscleService
            let result = try await service.searchMuscles(searchModel: searchModel)
            muscles = result.items ?? []
            totalPages = (Int)(result.totalPages!)
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func updateSearchModel(_ newSearchModel: Components.Schemas.SearchMuscleDto) {
        self.searchModel = newSearchModel
        Task {
            await searchMuscles()
        }
    }
}
