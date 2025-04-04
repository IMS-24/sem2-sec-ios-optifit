import UIKit

class HapticFeedbackManager {
    @MainActor static let shared = HapticFeedbackManager()

    // Triggers a strong vibration
    func triggerVibration() async {
        Task{
            let generator = await UINotificationFeedbackGenerator()
            await generator.notificationOccurred(.error)  // Strongest vibration type
        }
    }
}
