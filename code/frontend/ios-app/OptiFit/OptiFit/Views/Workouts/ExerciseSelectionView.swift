//
//  ExerciseSelectionView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import SwiftUI

struct ExerciseSelectionView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    let exerciseTypeId: UUID
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
            let updatedSearchModel = SearchExercisesDto(exerciseTypeId: exerciseTypeId)
            exerciseViewModel.updateSearchModel(updatedSearchModel)
        }
    }
}
#Preview {
    ExerciseSelectionView(exerciseTypeId: UUID())
}
