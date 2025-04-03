import SwiftUI

extension NumberFormatter {
    static var integerFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }
    
    static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
struct WorkoutSetRowView: View {
    @Binding var set: Components.Schemas.CreateWorkoutSetDto
    let index: Int
    let onDelete: (Int) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Text("Set \(index + 1):")
                .frame(width: 60, alignment: .leading)
            
            // Reps input field with integer binding.
            TextField("Reps", value: Binding(
                get: { set.reps ?? 0 },
                set: { set.reps = $0 }
            ), formatter: NumberFormatter.integerFormatter)
            .keyboardType(.numberPad)
            .frame(width: 60)
            
            // Weight input field with decimal binding.
            TextField("Weight", value: Binding(
                get: { set.weight ?? 0.0 },
                set: { set.weight = $0 }
            ), formatter: NumberFormatter.decimalFormatter)
            .keyboardType(.decimalPad)
            .frame(width: 80)
            
            Spacer()
            
            // Delete button.
            Button {
                onDelete(index)
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(8)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}
