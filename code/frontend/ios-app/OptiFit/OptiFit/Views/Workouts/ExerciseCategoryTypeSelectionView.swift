//
//  WorkoutSelectionView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 20.02.25.
//

import SwiftUI

struct ExerciseCategoryTypeSelectionView: View {
    @StateObject private var exerciseCategoriesViewModel = ExerciseCategoryViewModel()

    var body: some View {
        List(exerciseCategoriesViewModel.exerciseCategories) { exerciseCategory in
            NavigationLink(destination: ExerciseSelectionView(exerciseCategoryId: exerciseCategory.id)) {
                Text(exerciseCategory.i18NCode)
            }
        }
                .navigationTitle("Select Category")
    }
}

#Preview {
    ExerciseCategoryTypeSelectionView()
}
