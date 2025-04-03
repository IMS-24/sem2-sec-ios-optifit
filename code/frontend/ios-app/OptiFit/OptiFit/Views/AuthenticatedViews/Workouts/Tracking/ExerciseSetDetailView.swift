import SwiftUI

extension Binding {
    func unwrap<T>() -> Binding<[T]> where Value == [T]? {
        Binding<[T]>(
            get: { self.wrappedValue ?? [] },
            set: { self.wrappedValue = $0 }
        )
    }
}
struct ExerciseSetDetailView: View {
    let selectedExercise: Components.Schemas.GetExerciseDto
    let order: Int
    let onSave: (Components.Schemas.CreateWorkoutExerciseDto) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var createWorkoutExerciseDto: Components.Schemas.CreateWorkoutExerciseDto
    
    init(selectedExercise: Components.Schemas.GetExerciseDto, order: Int, onSave: @escaping (Components.Schemas.CreateWorkoutExerciseDto) -> Void) {
        self.selectedExercise = selectedExercise
        self.order = order
        self.onSave = onSave
        
        _createWorkoutExerciseDto = State(
            initialValue: Components.Schemas.CreateWorkoutExerciseDto(
                id: UUID().uuidString,
                order: Int32(order),
                exercise: selectedExercise,
                notes: "",
                workoutSets: []  // Initialize with an empty array.
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Exercise") {
                    Text(selectedExercise.i18NCode ?? "Unknown")
                }
                Section("Sets") {
                    // Use the binding version of WorkoutSetsEntryView.
                    WorkoutSetsEntryView(
                        sets: $createWorkoutExerciseDto.workoutSets.unwrap(),
                        onDeleteSet: { index in
                            // Remove element safely from the unwrapped array.
                            if createWorkoutExerciseDto.workoutSets?.indices.contains(index) == true {
                                createWorkoutExerciseDto.workoutSets!.remove(at: index)
                            }
                        }
                    )
                    
                    // "Add Set" button.
                    Button(action: addSet) {
                        Label("Add Set", systemImage: "plus.circle.fill")
                    }
                }
                
                Section("Notes") {
                    TextEditor(
                        text: Binding(
                            get: { createWorkoutExerciseDto.notes ?? "" },
                            set: { createWorkoutExerciseDto.notes = $0 }
                        )
                    )
                    .frame(height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Add Set Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let workoutExercise = Components.Schemas.CreateWorkoutExerciseDto(
                            id: UUID().uuidString,
                            order: Int32(order),
                            exercise: selectedExercise,
                            notes: createWorkoutExerciseDto.notes,
                            workoutSets: createWorkoutExerciseDto.workoutSets
                        )
                        print("[DEBUG] Save workoutExercise: \(workoutExercise)")
                        onSave(workoutExercise)
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addSet() {
        // Get the current sets (if nil, treat as empty).
        let currentSets = createWorkoutExerciseDto.workoutSets ?? []
        
        // Compute the new order by checking the last element.
        let newOrder = (currentSets.last?.order ?? 0) + 1
        
        let newSet = Components.Schemas.CreateWorkoutSetDto(
            id: UUID().uuidString,
            order: newOrder,
            reps: nil,
            weight: nil
        )
        
        // If workoutSets is nil, initialize it with the new set.
        if createWorkoutExerciseDto.workoutSets == nil {
            createWorkoutExerciseDto.workoutSets = [newSet]
        } else {
            // Force unwrap here is safe since we checked for nil.
            createWorkoutExerciseDto.workoutSets!.append(newSet)
        }
    }
}
