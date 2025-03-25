import UIKit

class HapticFeedbackManager {
    static let shared = HapticFeedbackManager()

    // Triggers a strong vibration
    func triggerVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)  // Strongest vibration type
    }
}
