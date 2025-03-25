import SwiftUI

struct QuickActionsView: View {
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                print("Start Workout tapped")
            }) {
                Label("Start Workout", systemImage: "play.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(QuickActionButtonStyle(color: Color(.primaryAccent)))

            Button(action: {
                print("View Exercises tapped")
            }) {
                Label("Exercises", systemImage: "list.bullet.rectangle")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(QuickActionButtonStyle(color: Color(.secondaryAccent)))
        }
        .padding()
    }
}

struct QuickActionButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .font(Font.headline)
            .foregroundColor(Color(.primaryText))
            .padding()
            .background(
                Capsule()
                    .fill(color)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(Animation.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    QuickActionsView()
}
