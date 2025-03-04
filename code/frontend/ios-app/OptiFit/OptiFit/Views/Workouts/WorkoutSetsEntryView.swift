import SwiftUI

struct WorkoutSetsEntryView: View {
    @Binding var sets: [WorkoutSet]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(sets.indices, id: \.self) { index in
                HStack {
                    Text("Set \(index + 1):")
                        .frame(width: 50, alignment: .leading)
                    
                    // Reps field
                    TextField("Reps", value: Binding(
                        get: { sets[index].reps ?? 0 },
                        set: { newValue in sets[index].reps = newValue }
                    ), format: .number)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // Weight field
                    TextField("Weight", value: Binding(
                        get: { sets[index].weight ?? 0.0 },
                        set: { newValue in sets[index].weight = newValue }
                    ), format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.vertical, 4)
            }
            
            Button(action: {
                // Append a new set with an incremental order (optional).
                sets.append(WorkoutSet(order: sets.count + 1, reps: nil, weight: nil))
            }) {
                Label("Add Set", systemImage: "plus.circle.fill")
            }
            .padding(.vertical, 8)
        }
        .padding()
    }
}
