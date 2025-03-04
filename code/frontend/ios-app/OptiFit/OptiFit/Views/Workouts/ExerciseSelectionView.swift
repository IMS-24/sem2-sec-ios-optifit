//
//  ExerciseSelectionView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import SwiftUI

struct ExerciseSelectionView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    let exerciseCategoryId: UUID
    //    @State private var selectedExercise: String = ""
    
    var body: some View {
        // TODO: Filter exercises by type
        List(exerciseViewModel.exercises) { exercise in
//                        NavigationLink(destination: WorkoutTrackingView()) {
                            Text(exercise.i18NCode)
//                        }
        }
        .navigationTitle("Select Exercise")
        .onAppear {
            let updatedSearchModel = SearchExercisesDto(exerciseCategoryId: exerciseCategoryId)
            exerciseViewModel.updateSearchModel(updatedSearchModel)
        }
    }
}
#Preview {
    ExerciseSelectionView(exerciseCategoryId: UUID())
}
