import SwiftUI

struct WorkoutTrackingActionButtonView: View {
    let onSave: () -> Void
    let onCancel: () -> Void
    var body: some View {
        // Bottom Action Buttons: Save and Cancel
        HStack {
            Button(action: onSave) {
                Label("Save", systemImage: "checkmark")
            }
            .buttonStyle(.bordered)
            .controlSize(.small)

            Spacer()

            Button(action: onCancel) {
                Label("Cancel", systemImage: "xmark")
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
            .tint(.red)
        }
        .padding(.horizontal)
    }
}
