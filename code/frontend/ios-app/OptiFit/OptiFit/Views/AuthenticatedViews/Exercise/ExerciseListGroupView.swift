import SwiftUI

struct ExerciseListGroupView: View {
    var groupedExercises: [String: [Components.Schemas.GetExerciseDto]]

    init(groupedExercises: [String: [Components.Schemas.GetExerciseDto]]) {
        self.groupedExercises = groupedExercises
    }

    var body: some View {
        List(groupedExercises.keys.sorted(), id: \.self) { group in
            Section(header: Text(group)) {
                ForEach(groupedExercises[group] ?? [], id: \.id) { exercise in
                    HStack {
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                            ExerciseListEntryView(exercise: exercise)
                                .padding(.vertical, 5)
                        }
                    }
                    //                    .onAppear {
                    //                                // If this is the last exercise, load more.
                    //                                if exercise.id == exerciseViewModel.exercises.last?.id {
                    //                                    Task {
                    //                                        await exerciseViewModel.loadMoreExercises()
                    //                                    }
                    //                                }
                    //                            }
                    //                            .swipeActions {
                    //                                // Edit swipe action navigates to detail view in edit mode.
                    //                                Button {
                    //                                    selectedExerciseForEdit = exercise
                    //                                } label: {
                    //                                    Label("Edit", systemImage: "pencil")
                    //                                }
                    //                                // Delete swipe action.
                    //                                Button(role: .destructive) {
                    //                                    Task {
                    //                                        let success = await exerciseViewModel.deleteExercise(exerciseId: exercise.id)
                    //                                        if success {
                    //                                            // Optionally update UI, e.g., by removing the item locally.
                    //                                        }
                    //                                    }
                    //                                } label: {
                    //                                    Label("Delete", systemImage: "trash")
                    //                                }
                    //                            }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())

    }
}
//
//#Preview {
//    let exerciseCategories = [
//        Components.Schemas.GetExerciseCategoryDto(id: UUID().uuidString, i18NCode: "Leg"),
//        Components.Schemas.GetExerciseCategoryDto(id: UUID().uuidString, i18NCode: "Core"),
//    ]
//    ExerciseListGroupView(groupedExercises: [
//        "Legs": [
//            Components.Schemas.GetExerciseDto(
//                id: UUID(uuidString: "846E8C2D-9D63-4C18-82FA-0D8C7512F326")?.uuidString,
//                i18NCode: "Bench Press",
//                description: "A compound movement that works the chest, shoulders, and triceps.",
//                exerciseCategory: exerciseCategories[1],
//                exerciseCategoryId: exerciseCategories[1].id
//            ),
//            Components.Schemas.GetExerciseDto(
//                id: UUID(uuidString: "D3BE9295-9477-4A98-8AEA-A4DADE7A073D")?.uuidString,
//                i18NCode: "Cable Lateral Raise",
//                description: "A shoulder isolation movement that targets the side delts.",
//                exerciseCategory: exerciseCategories[1],
//                exerciseCategoryId: exerciseCategories[1].id
//            ),
//        ],
//        "Core": [
//            Components.Schemas.GetExerciseDto(
//                id: UUID(uuidString: "C99C49DC-A5A7-41B5-9A13-68F2149B6392")?.uuidString,
//                i18NCode: "Box Jump",
//                description: "An explosive movement that enhances power and agility.",
//                exerciseCategory: exerciseCategories[2],
//                exerciseCategoryId: exerciseCategories[2].id
//            ),
//            Components.Schemas.GetExerciseDto(
//                id: UUID(uuidString: "9F2DA650-2043-4F4C-911B-AB0591AF0E72")?.uuidString,
//                i18NCode: "Calf Raise",
//                description: "An exercise that strengthens and tones the calf muscles.",
//                exerciseCategory: exerciseCategories[2],
//                exerciseCategoryId: exerciseCategories[2].id
//            ),
//            Components.Schemas.GetExerciseDto(
//                id: UUID(uuidString: "A5556D61-7CBC-441D-8261-1C325EE098F4")?.uuidString,
//                i18NCode: "Good Morning",
//                description: "A posterior chain exercise that strengthens the hamstrings and lower back.",
//                exerciseCategory: exerciseCategories[2],
//                exerciseCategoryId: exerciseCategories[2].id
//            ),
//        ],
//        //        "pull": [
//        //            GetExerciseDto(
//        //                    id: UUID(uuidString: "D3D536FE-8D14-4EB3-AF07-05281BC3B92E")!,
//        //                    i18NCode: "Bent-Over Row",
//        //                    description: "A pulling movement that targets the upper and middle back.",
//        //                    exerciseCategoryId: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!,
//        //                    exerciseCategory: "pull"//,
//        ////                imageURL: nil
//        //            )
//        //        ],
//        //        "core": [
//        //            GetExerciseDto(
//        //                    id: UUID(uuidString: "5E3DCFA2-DDB7-409D-AB6E-2555D6F988DF")!,
//        //                    i18NCode: "Cable Crunch",
//        //                    description: "A weighted crunch variation that targets the abs more intensely.",
//        //                    exerciseCategoryId: UUID(uuidString: "77777777-7777-7777-7777-777777777777")!,
//        //                    exerciseCategory: "core"//,
//        ////                imageURL: nil
//        //            ),
//        //            GetExerciseDto(
//        //                    id: UUID(uuidString: "28C267C0-6ACA-4E25-999A-F265299FBE12")!,
//        //                    i18NCode: "Hanging Knee Raise",
//        //                    description: "A hanging exercise that engages the core and lower abs.",
//        //                    exerciseCategoryId: UUID(uuidString: "88888888-8888-8888-8888-888888888888")!,
//        //                    exerciseCategory: "core"//,
//        ////                imageURL: nil
//        //            )
//        //        ]
//    ])
//}
