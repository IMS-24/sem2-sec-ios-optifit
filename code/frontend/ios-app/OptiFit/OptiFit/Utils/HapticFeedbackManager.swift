//
//  HapticFeedbackManager.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 07.03.25.
//


import UIKit

class HapticFeedbackManager {
    static let shared = HapticFeedbackManager()

    // Triggers a strong vibration
    func triggerVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error) // Strongest vibration type
    }
}
