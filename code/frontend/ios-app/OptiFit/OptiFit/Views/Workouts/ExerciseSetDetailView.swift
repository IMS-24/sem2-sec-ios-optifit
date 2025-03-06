//Done: 2025-03-05: 15:07

import SwiftUI

struct ExerciseSetDetailView: View {
    let selectedExercise: GetExerciseDto
    @State private var createWorkoutExerciseDto: CreateWorkoutExerciseDto
    let order: Int

    init(selectedExercise: GetExerciseDto, order: Int, onSave: @escaping (CreateWorkoutExerciseDto) -> Void) {
        self.order = order
        self.selectedExercise = selectedExercise
        _createWorkoutExerciseDto = State(initialValue: CreateWorkoutExerciseDto(
            id:UUID(),
                order: order,
                exercise: selectedExercise,
                notes: "",
                workoutSets: []
        ))
        self.onSave = onSave
    }

    public let onSave: (CreateWorkoutExerciseDto) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Exercise")) {
                    Text(selectedExercise.i18NCode)
                }
                Section(header: Text("Enter Sets")) {
                    WorkoutSetsEntryView(sets: $createWorkoutExerciseDto.workoutSets)
                            .frame(maxHeight: .infinity)
                }
                Section(header: Text("Notes")) {
                    Text("Cooming Soon")
//                    TextEditor(text: $createWorkoutExerciseDto.notes)
//                            .frame(minHeight: 100)
//                            .overlay(RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.gray, lineWidth: 1))
//                            .padding(.top, 4)

                }
            }
                    .navigationTitle("Add Set Info")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {
                                let workoutExercise = CreateWorkoutExerciseDto(id:UUID(),order: order, exercise: selectedExercise, workoutSets: createWorkoutExerciseDto.workoutSets)
                                onSave(workoutExercise)
                            }
                        }
                    }
        }
    }
}
struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
