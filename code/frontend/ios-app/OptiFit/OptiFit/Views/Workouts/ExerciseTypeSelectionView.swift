//
//  WorkoutSelectionView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import SwiftUI

struct ExerciseTypeSelectionView: View {
    @StateObject private var exerciseTypesViewModel = ExerciseTypeViewModel()

    var body: some View {
        List(exerciseTypesViewModel.exerciseTypes) { exerciseType in
            NavigationLink(destination: ExerciseSelectionView(exerciseTypeId: exerciseType.id)) {
                Text(exerciseType.i18NCode)
            }
        }
                .navigationTitle("Select Type")
    }
}

#Preview {
    ExerciseTypeSelectionView()
}
