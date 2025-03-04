import SwiftUI

struct ExerciseListGroupView: View {
    var groupedExercises: [String: [GetExerciseDto]]

    init(groupedExercises: [String: [GetExerciseDto]]) {
        self.groupedExercises = groupedExercises
        print(groupedExercises)
    }

    var body: some View {
        List(groupedExercises.keys.sorted(), id: \.self) { group in
            Section(header: Text(group)) {
                ForEach(groupedExercises[group] ?? [], id: \.id) { exercise in
                    ExerciseListEntryView(exercise: exercise)
                }
            }
        }
    }
}

#Preview {
    ExerciseListGroupView(groupedExercises: [
        "push": [
            GetExerciseDto(
                id: UUID(uuidString: "846E8C2D-9D63-4C18-82FA-0D8C7512F326")!,
                i18NCode: "Bench Press",
                description: "A compound movement that works the chest, shoulders, and triceps.",
                exerciseCategoryId: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
                exerciseCategory: "push"//,
//                imageURL: nil
            ),
            GetExerciseDto(
                id: UUID(uuidString: "D3BE9295-9477-4A98-8AEA-A4DADE7A073D")!,
                i18NCode: "Cable Lateral Raise",
                description: "A shoulder isolation movement that targets the side delts.",
                exerciseCategoryId: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
                exerciseCategory: "push"//,
//                imageURL: nil
            )
        ],
        "legs": [
            GetExerciseDto(
                id: UUID(uuidString: "C99C49DC-A5A7-41B5-9A13-68F2149B6392")!,
                i18NCode: "Box Jump",
                description: "An explosive movement that enhances power and agility.",
                exerciseCategoryId: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
                exerciseCategory: "legs"//,
//                imageURL: nil
            ),
            GetExerciseDto(
                id: UUID(uuidString: "9F2DA650-2043-4F4C-911B-AB0591AF0E72")!,
                i18NCode: "Calf Raise",
                description: "An exercise that strengthens and tones the calf muscles.",
                exerciseCategoryId: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
                exerciseCategory: "legs"//,
//                imageURL: nil
            ),
            GetExerciseDto(
                id: UUID(uuidString: "A5556D61-7CBC-441D-8261-1C325EE098F4")!,
                i18NCode: "Good Morning",
                description: "A posterior chain exercise that strengthens the hamstrings and lower back.",
                exerciseCategoryId: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
                exerciseCategory: "legs"//,
//                imageURL: nil
            )
        ],
        "pull": [
            GetExerciseDto(
                id: UUID(uuidString: "D3D536FE-8D14-4EB3-AF07-05281BC3B92E")!,
                i18NCode: "Bent-Over Row",
                description: "A pulling movement that targets the upper and middle back.",
                exerciseCategoryId: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!,
                exerciseCategory: "pull"//,
//                imageURL: nil
            )
        ],
        "core": [
            GetExerciseDto(
                id: UUID(uuidString: "5E3DCFA2-DDB7-409D-AB6E-2555D6F988DF")!,
                i18NCode: "Cable Crunch",
                description: "A weighted crunch variation that targets the abs more intensely.",
                exerciseCategoryId: UUID(uuidString: "77777777-7777-7777-7777-777777777777")!,
                exerciseCategory: "core"//,
//                imageURL: nil
            ),
            GetExerciseDto(
                id: UUID(uuidString: "28C267C0-6ACA-4E25-999A-F265299FBE12")!,
                i18NCode: "Hanging Knee Raise",
                description: "A hanging exercise that engages the core and lower abs.",
                exerciseCategoryId: UUID(uuidString: "88888888-8888-8888-8888-888888888888")!,
                exerciseCategory: "core"//,
//                imageURL: nil
            )
        ]
    ])
}
