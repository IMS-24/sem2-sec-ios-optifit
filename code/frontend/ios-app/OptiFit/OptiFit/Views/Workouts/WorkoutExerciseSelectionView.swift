//
//  WorkoutExerciseSelectionView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 22.02.25.
//


import SwiftUI

struct WorkoutExerciseSelectionView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    // In a production app, you’d retrieve these from a view model or network.
    let exercises: [Exercise] = [] // sampleExercises should be defined elsewhere
    
    var body: some View {
//        List(exerciseViewModel.exercises) { exercise in
//            NavigationLink(destination: WorkoutTrackingView()) {
//                HStack {
//                    // Optionally show an exercise image if available.
//                    if let imageURL = exercise.imageURL {
//                        AsyncImage(url: imageURL) { phase in
//                            switch phase {
//                            case .empty:
//                                ProgressView()
//                                    .frame(width: 50, height: 50)
//                            case .success(let image):
//                                image
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 50, height: 50)
//                                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                            case .failure:
//                                Image(systemName: "photo")
//                                    .frame(width: 50, height: 50)
//                            @unknown default:
//                                EmptyView()
//                            }
//                        }
//                    }
//                    Text(exercise.i18NCode)
//                        .font(.headline)
//                }
//                .padding(.vertical, 5)
//            }
//        }
//        .navigationTitle("Select Exercise")
        Text("Dumm aselection")
    }
}

#Preview {
    WorkoutExerciseSelectionView()
}
