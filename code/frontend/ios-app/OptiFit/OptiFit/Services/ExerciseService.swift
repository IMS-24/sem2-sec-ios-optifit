import Foundation

@MainActor
class ExerciseService: ObservableObject {
    @Published var exerciseTypes: [ExerciseType] = []
    @Published var exercises: [Exercise] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage?

    private let baseURL = "\(Configuration.apiBaseURL.absoluteString)/exercise"

    func fetchExerciseTypes() async {
        guard let url = URL(string: "\(baseURL)/types") else {
            errorMessage = ErrorMessage(message: "Invalid URL")
            return
        }

        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            exerciseTypes = try decoder.decode([ExerciseType].self, from: data)
        } catch {
            errorMessage = ErrorMessage(message: "Failed to load ExerciseTypes")
        }
    }

    // Updated search function that supports lazy loading
    func searchExercises(searchModel: SearchExercisesDto, append: Bool = false) async -> PaginatedResult<Exercise>? {
        guard let url = URL(string: "\(baseURL)/search") else {
            errorMessage = ErrorMessage(message: "Invalid URL")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(searchModel)
        } catch {
            errorMessage = ErrorMessage(message: "Failed to encode search request")
            return nil
        }

        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(PaginatedResult<Exercise>.self, from: data)
            if append {
                exercises.append(contentsOf: response.items)
            } else {
                exercises = response.items
            }
            return response
        } catch {
            errorMessage = ErrorMessage(message: "Failed to decode Exercise response from server")
            return nil
        }
    }

    func postExercise(_ exercise: PostExerciseDto) async {
        guard let url = URL(string: "\(baseURL)") else {
            errorMessage = ErrorMessage(message: "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(exercise)
        } catch {
            errorMessage = ErrorMessage(message: "Failed to encode exercise")
            return
        }

        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let newExercise = try decoder.decode(Exercise.self, from: data)
            exercises.append(newExercise)
        } catch {
            errorMessage = ErrorMessage(message: "Failed to decode Exercise")
        }
    }

    func deleteExercise(withId id: UUID) async {
        // TODO: Implement delete functionality
        print("Delete exercise with id: \(id)")
    }
}
