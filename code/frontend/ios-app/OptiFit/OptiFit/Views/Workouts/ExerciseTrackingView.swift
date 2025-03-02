import SwiftUI

struct ExerciseTrackingView: View {
    let exercise: GetExerciseDto
    @State private var sets: [WorkoutSet] = []
    var onFinish: (PerformedExercise) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text(exercise.i18NCode)
                .font(.largeTitle)
                .padding()
            
            if let desc = exercise.description, !desc.isEmpty {
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.headline)
                    Text(desc)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            
            List {
                ForEach(sets.indices, id: \.self) { index in
                    SetInputView(set: $sets[index])
                }
                .onDelete { indices in
                    sets.remove(atOffsets: indices)
                }
                .onMove { indices, newOffset in
                    sets.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .toolbar {
                EditButton()
            }
            
            Button("Add Set") {
                sets.append(WorkoutSet())
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Finish Exercise") {
                let performed = PerformedExercise(name: exercise.i18NCode, sets: sets)
                onFinish(performed)
                dismiss()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .navigationTitle("Track Exercise")
    }
}

#Preview {
    ExerciseTrackingView(
        exercise: GetExerciseDto(
            id: UUID(),
            i18NCode: "Exercise",
            description: "Some Description",
            exerciseCategoryId: UUID(),
            exerciseCategory: "Some Type",
            imageURL: nil
        )
    ) { _ in }
}
