import SwiftUI

struct ExerciseListGroupView: View {
    var groupedExercises: [String: [Exercise]]

    init(groupedExercises: [String: [Exercise]]) {
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
            Exercise(id: UUID(uuidString: "846E8C2D-9D63-4C18-82FA-0D8C7512F326")!,
                    i18NCode: "Bench Press",
                    description: Optional("A compound movement that works the chest, shoulders, and triceps."),
                    muscleGroups: [
                        MuscleGroup(id: UUID(uuidString: "E05DE925-1E66-4547-8950-1D26E5DE9E11")!,
                                i18NCode: "chest",
                                muscles: [
                                    Muscle(id: UUID(uuidString: "EB36B354-EF08-4BBF-B41B-244788BD62E1")!, i18NCode: "serratus_anterior"),
                                    Muscle(id: UUID(uuidString: "DBF4EE29-C4D0-4D5E-8846-78C2632D4EA3")!, i18NCode: "pectoralis_major"),
                                    Muscle(id: UUID(uuidString: "4805C4A7-9D81-4EEE-951A-BA82AAEB0EFB")!, i18NCode: "pectoralis_minor")
                                ])
                    ],
                    muscles: [],
                    exerciseType: "push",
                    imageURL: nil),

            Exercise(id: UUID(uuidString: "D3BE9295-9477-4A98-8AEA-A4DADE7A073D")!,
                    i18NCode: "Cable Lateral Raise",
                    description: Optional("A shoulder isolation movement that targets the side delts."),
                    muscleGroups: [
                        MuscleGroup(id: UUID(uuidString: "AF4D7669-3A4A-480B-B8AA-17E39AD4D8C8")!,
                                i18NCode: "shoulders",
                                muscles: [
                                    Muscle(id: UUID(uuidString: "321EBC13-5400-44F6-9334-14BAC89618AD")!, i18NCode: "erector_spinae"),
                                    Muscle(id: UUID(uuidString: "A8B00E77-002C-4DB3-A22F-892934250F1B")!, i18NCode: "trapezius"),
                                    Muscle(id: UUID(uuidString: "EB36B354-EF08-4BBF-B41B-244788BD62E1")!, i18NCode: "serratus_anterior")
                                ])
                    ],
                    muscles: [],
                    exerciseType: "push",
                    imageURL: nil)
        ],
        "legs": [
            Exercise(id: UUID(uuidString: "C99C49DC-A5A7-41B5-9A13-68F2149B6392")!,
                    i18NCode: "Box Jump",
                    description: Optional("An explosive movement that enhances power and agility."),
                    muscleGroups: [
                        MuscleGroup(id: UUID(uuidString: "4279276A-EC31-4DC7-B4B4-B490D67ACBD0")!,
                                i18NCode: "legs",
                                muscles: [])
                    ],
                    muscles: [],
                    exerciseType: "legs",
                    imageURL: nil),

            Exercise(id: UUID(uuidString: "9F2DA650-2043-4F4C-911B-AB0591AF0E72")!,
                    i18NCode: "Calf Raise",
                    description: Optional("An exercise that strengthens and tones the calf muscles."),
                    muscleGroups: [
                        MuscleGroup(id: UUID(uuidString: "4279276A-EC31-4DC7-B4B4-B490D67ACBD0")!,
                                i18NCode: "legs",
                                muscles: [])
                    ],
                    muscles: [],
                    exerciseType: "legs",
                    imageURL: nil),

            Exercise(id: UUID(uuidString: "A5556D61-7CBC-441D-8261-1C325EE098F4")!,
                    i18NCode: "Good Morning",
                    description: Optional("A posterior chain exercise that strengthens the hamstrings and lower back."),
                    muscleGroups: [
                        MuscleGroup(id: UUID(uuidString: "4279276A-EC31-4DC7-B4B4-B490D67ACBD0")!,
                                i18NCode: "legs",
                                muscles: [])
                    ],
                    muscles: [],
                    exerciseType: "legs",
                    imageURL: nil)
        ],
        "pull": [
            Exercise(id: UUID(uuidString: "D3D536FE-8D14-4EB3-AF07-05281BC3B92E")!,
                    i18NCode: "Bent-Over Row",
                    description: Optional("A pulling movement that targets the upper and middle back."),
                    muscleGroups: [
                        MuscleGroup(id: UUID(uuidString: "D26ED0C4-2941-49E9-9C09-EFCE5663AB92")!,
                                i18NCode: "back",
                                muscles: [
                                    Muscle(id: UUID(uuidString: "23893AFE-3D7B-4202-90E9-30D5F8CE1875")!, i18NCode: "deltoid_posterior"),
                                    Muscle(id: UUID(uuidString: "321EBC13-5400-44F6-9334-14BAC89618AD")!, i18NCode: "erector_spinae"),
                                    Muscle(id: UUID(uuidString: "A8B00E77-002C-4DB3-A22F-892934250F1B")!, i18NCode: "trapezius")
                                ])
                    ],
                    muscles: [],
                    exerciseType: "pull",
                    imageURL: nil)
        ],
        "core": [
            Exercise(id: UUID(uuidString: "5E3DCFA2-DDB7-409D-AB6E-2555D6F988DF")!,
                    i18NCode: "Cable Crunch",
                    description: Optional("A weighted crunch variation that targets the abs more intensely."),
                    muscleGroups: [
                        MuscleGroup(id: UUID(uuidString: "CA487800-5FB6-46BD-A4A2-920234FA3008")!,
                                i18NCode: "core",
                                muscles: [])
                    ],
                    muscles: [],
                    exerciseType: "core",
                    imageURL: nil),

            Exercise(
                    id: UUID(uuidString: "28C267C0-6ACA-4E25-999A-F265299FBE12")!,
                    i18NCode: "Hanging Knee Raise",
                    description: Optional("A hanging exercise that engages the core and lower abs."),
                    muscleGroups: [
                        MuscleGroup(
                                id: UUID(uuidString: "CA487800-5FB6-46BD-A4A2-920234FA3008")!,
                                i18NCode: "core",
                                muscles: []
                        )
                    ],
                    muscles: [],
                    exerciseType: "core",
                    imageURL: nil
            )
        ]
    ])

}
