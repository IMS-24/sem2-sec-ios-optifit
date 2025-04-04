import Combine
import Foundation

@MainActor
class GymViewModel: ObservableObject {
    @Published var gyms: [Components.Schemas.GetGymDto] = []
    @Published var errorMessage: ErrorMessage?

    private var searchModel: Components.Schemas.SearchGymsDto = Components.Schemas.SearchGymsDto()
    private let gymService: GymServiceProtocol

    private var currentPage: Int = 0
    private var totalPages: Int = 1
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false

    init(gymService: GymServiceProtocol = GymService()) {
        self.gymService = gymService
    }
    func searchGyms() async {
        isLoading = true
        errorMessage = nil
        do {
            currentPage = 0
            let result = try await gymService.searchGym(searchModel: searchModel)
            gyms = result.items ?? []
            totalPages = (Int)(result.totalPages!)
        } catch {
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }

    func updateSearchModel(_ newModel: Components.Schemas.SearchGymsDto) {
        searchModel = newModel
    }
}
