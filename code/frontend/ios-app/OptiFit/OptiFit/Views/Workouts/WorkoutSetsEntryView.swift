//Done: 2025-03-05: 15:07

import SwiftUI

struct WorkoutSetsEntryView: View {
    @Binding var sets: [CreateWorkoutSetDto]
    var body: some View {
        // Using a List enables built‑in reordering and deletion.
        List {
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
                            .textFieldStyle(.roundedBorder)

                    // Weight field
                    TextField("Weight", value: Binding(
                            get: { sets[index].weight ?? 0.0 },
                            set: { newValue in sets[index].weight = newValue }
                    ), format: .number)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                }
                        .padding(.vertical, 4)
            }
                    .onDelete(perform: deleteSet)
                    .onMove(perform: moveSet)
        }
                .listStyle(.plain)
                .frame(height: CGFloat(sets.count * 60)) // adjust height if needed
                .toolbar {
                    EditButton()
                }
                .padding(.vertical, 8)

        Button(action: addSet) {
            Label("Add Set", systemImage: "plus.circle.fill")
        }
                .padding(.vertical, 8)
    }

    private func deleteSet(at offsets: IndexSet) {
        sets.remove(atOffsets: offsets)
    }

    private func moveSet(from source: IndexSet, to destination: Int) {
        sets.move(fromOffsets: source, toOffset: destination)
    }

    private func addSet() {
        let newOrder = (sets.last?.order ?? 0) + 1
        sets.append(CreateWorkoutSetDto(order: newOrder, reps: nil, weight: nil))
    }
}
