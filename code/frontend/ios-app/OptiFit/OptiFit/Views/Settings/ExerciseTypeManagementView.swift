//
//  ExerciseTypeManagementView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct ExerciseTypeManagementView: View {
    @StateObject private var exerciseTypesViewModel = ExerciseTypeViewModel()

    var body: some View {
        NavigationView {
            List(exerciseTypesViewModel.exerciseTypes) { exerciseType in
                Section(header: Text(exerciseType.i18NCode)) {
                    ForEach(exerciseType.exercises ?? []) { exercise in
                        Text(exercise.description!)
                    }
                }
            }
                    .navigationTitle("Exercise Types")
                    .onAppear {
                        exerciseTypesViewModel.fetchExerciseTypes()
                    }
                    .alert(item: $exerciseTypesViewModel.errorMessage) { error in
                        Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                    }
        }
    }
}

#Preview {
    ExerciseTypeManagementView()
}
