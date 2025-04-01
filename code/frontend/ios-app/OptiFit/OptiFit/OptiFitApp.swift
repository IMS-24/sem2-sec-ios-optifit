//
//  OptiFitApp.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

@main
struct OptiFitApp: App {
//    @StateObject private var idleTimerManager = IdleTimerManager.shared
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
//                .gesture(DragGesture().onChanged { _ in idleTimerManager.resetIdleTimer() }) // Detect touch gestures globally
//                .onTapGesture { idleTimerManager.resetIdleTimer() }
        }
    }
}
