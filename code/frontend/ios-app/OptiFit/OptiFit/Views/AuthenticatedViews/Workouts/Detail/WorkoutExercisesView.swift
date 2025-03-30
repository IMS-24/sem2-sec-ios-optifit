//
//  WorkoutExercisesView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 30.03.25.
//

import SwiftUI

struct WorkoutExercisesView: View {
    let workout: Components.Schemas.GetWorkoutDto
    var body: some View {
        // Exercises Section – List of performed exercises.
        VStack(alignment: .leading, spacing: 8) {
            Text("Exercises")
                .font(.headline)
                .padding(.horizontal)
            if let workoutExercises = workout.workoutExercises, !workoutExercises.isEmpty {
                ForEach(
                    workoutExercises.sorted(by: { $0.order! < $1.order! }
                    ), id: \.id
                ) { workoutExercise in
                    NavigationLink {
                        WorkoutExerciseDetailsView(workoutExercise: workoutExercise)
                    } label: {
                        HStack {
                            Text(workoutExercise.exercise!.i18NCode!)
                                .font(.body)
                                .foregroundColor(Color(.primaryText))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.secondaryBackground))
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("No exercises available.")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
        }
    }
}

//#Preview {
//    WorkoutExercisesView()
//}
