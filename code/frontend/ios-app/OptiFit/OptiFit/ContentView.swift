//
//  ContentView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.accessToken != nil {
                AuthContentView()
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
        // Optionally animate the transition between views
        .animation(.easeInOut, value: authViewModel.accessToken)
    }
}
#Preview {
    ContentView()
}
