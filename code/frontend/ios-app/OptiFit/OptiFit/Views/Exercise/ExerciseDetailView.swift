import SwiftUI

struct ExerciseDetailView: View {
    let exercise: GetExerciseDto
    @StateObject private var exerciseService = ExerciseService()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Exercise Image
                if let imageURL = exercise.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(height: 200)
                        case .success(let image):
                            image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                        case .failure:
                            Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                } else {
                    Image(systemName: "figure.strengthtraining.traditional")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                }

                // Exercise Name
                Text(exercise.i18NCode)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                Divider()

                // Description
                VStack(alignment: .leading, spacing: 4) {
                    Text("Description")
                            .font(.headline)
                    Text(exercise.description ?? "No description available.")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                }

                Divider()

                // Exercise Type
                HStack {
                    Text("Type:")
                            .font(.headline)
                    Text(exercise.exerciseCategory.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                }

                // Muscle Groups
//                VStack(alignment: .leading) {
//                    Text("Muscle Groups")
//                            .font(.headline)
//
//                    if exercise.muscleGroups.isEmpty {
//                        Text("None specified")
//                                .foregroundColor(.gray)
//                    } else {
//                        ForEach(exercise.muscleGroups, id: \.id) { muscleGroup in
//                            Text("• \(muscleGroup.i18NCode.capitalized)")
//                                    .foregroundColor(.secondary)
//                        }
//                    }
//                }

                Divider()

                // Muscles
                VStack(alignment: .leading) {
                    Text("Muscles")
                            .font(.headline)

//                    if exercise.muscles.isEmpty {
//                        Text("None specified")
//                                .foregroundColor(.gray)
//                    } else {
//                        ForEach(exercise.muscles, id: \.id) { muscle in
//                            Text("• \(muscle.i18NCode.capitalized)")
//                                    .foregroundColor(.secondary)
//                        }
//                    }
                }

                // Action Buttons
                HStack {
                    Button(action: {
                        print("Save tapped")
                    }) {
                        Label("Save", systemImage: "plus.app.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                    }

                    Button(action: {
                        Task {
                            await try exerciseService.deleteExercise(exerciseId: exercise.id)
                        }
                    }) {
                        Label("Delete", systemImage: "trash.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                    }
                }
                        .padding(.top, 10)
            }
                    .padding()
        }
                .navigationTitle(exercise.i18NCode)
    }
}

#Preview {
    ExerciseDetailView(
        exercise: GetExerciseDto(
                    id: UUID(),
                    i18NCode: "ExerciseName",
                    description: "ExerciseDescription",
                    exerciseCategoryId: UUID(),
                    exerciseCategory: "ExerciseCategory",
                    imageURL: URL(string: "https://example.com/exercise.jpg")
            )
    )
}
