

import Foundation
import Combine

@MainActor
class MuscleGroupViewModel: ObservableObject {
    @Published var muscleGroups: [MuscleGroup] = []
    @Published var errorMessage: ErrorMessage?
    @Published var searchModel = SearchMuscleGroupsDto()
    @Published  var isLoading:Bool = false
    private let muscleGroupService = MuscleGroupService()
    private var cancellables = Set<AnyCancellable>()
    

    
    func searchMuscleGroups() async {
        isLoading = true
        errorMessage = nil
        do{
            let response = try await muscleGroupService.searchMuscleGroups(searchModel: searchModel)
        }catch{
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func updateSearchModel(_ newModel: SearchMuscleGroupsDto) async {
        self.searchModel = newModel
          await searchMuscleGroups()
        
    }
}
