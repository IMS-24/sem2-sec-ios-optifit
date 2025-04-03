import SwiftUI

struct WorkoutSetsEntryView: View {
    @Binding var sets: [Components.Schemas.CreateWorkoutSetDto]
    let onDeleteSet: (Int) -> Void
    
    var body: some View {
        if sets.isEmpty {
            Text("No sets added yet.")
                .foregroundColor(.gray)
        } else {
            VStack(spacing: 12) {
                ForEach(sets.indices, id: \.self) { index in
                    WorkoutSetRowView(
                        set: $sets[index],
                        index: index,
                        onDelete: onDeleteSet
                    )
                }
            }
        }
    }
}
//
//#Preview {
//    WorkoutSetsEntryView(
//        sets: [
//            Components.Schemas.CreateWorkoutSetDto(
//                id: UUID().uuidString,
//                order: 1,
//                reps: 10,
//                weight: 20
//            ),
//            Components.Schemas.CreateWorkoutSetDto(
//                id: UUID().uuidString,
//                order: 2,
//                reps: 20,
//                weight: 40
//            ),
//            Components.Schemas.CreateWorkoutSetDto(
//                id: UUID().uuidString,
//                order: 3,
//                reps: 30,
//                weight: 60
//            ),
//        ],
//        onDeleteSet: { _ in },
//        onUpdateSet: { _, _, _ in }
//    )
//}
