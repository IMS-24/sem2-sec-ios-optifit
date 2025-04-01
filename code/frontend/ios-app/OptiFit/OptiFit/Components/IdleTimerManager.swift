import Combine
import Foundation
import SwiftUI
//
//class IdleTimerManager: ObservableObject {
//    @Published var isIdlePopupActive: Bool = false
//    private var idleTimer: DispatchSourceTimer?
//    private let idleTimeInterval: TimeInterval = 10  // 10 sec timeout
//    private let queue = DispatchQueue(label: "com.optiFit.idleTimer", qos: .background)
//
//    static let shared = IdleTimerManager()
//    private var cancellables = Set<AnyCancellable>()
//
//    init() {
//        registerGlobalActivityListener()
//        startIdleDetection()
//    }
//
//    /// Starts the idle timer efficiently
//    func startIdleDetection() {
//        idleTimer?.cancel()  // Cancel previous timer if exists
//
//        let timer = DispatchSource.makeTimerSource(queue: queue)
//        timer.schedule(deadline: .now() + idleTimeInterval)
//        timer.setEventHandler { [weak self] in
//            Task { @MainActor in
//                self?.triggerPopup()
//            }
//        }
//        timer.resume()
//        idleTimer = timer
//    }
//
//    /// Efficiently resets the idle timer
//    func resetIdleTimer() {
//        idleTimer?.cancel()
//        startIdleDetection()
//    }
//
//    /// Triggers the modal and stops idle detection temporarily
//    private func triggerPopup() {
//        isIdlePopupActive = true
//        idleTimer?.cancel()
//    }
//
//    /// Dismisses the modal and restarts idle detection
//    func dismissPopup() {
//        isIdlePopupActive = false
//        startIdleDetection()
//    }
//
//    /// Registers a global listener for all user activity
//    private func registerGlobalActivityListener() {
//        let notificationCenter = NotificationCenter.default
//        let events = [
//            UIApplication.willEnterForegroundNotification,
//            UIApplication.didBecomeActiveNotification,
//        ]
//
//        for event in events {
//            notificationCenter.publisher(for: event)
//                .sink { _ in self.resetIdleTimer() }
//                .store(in: &cancellables)
//        }
//
//        DispatchQueue.main.async {
//            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        }
//    }
//}
