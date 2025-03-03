//
//  HomeView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI


struct HomeView: View {
    @StateObject private var userProfileViewModel = UserProfileViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HeaderView()

                StatisticsView(stats: userProfileViewModel.stats)

                ActivityGraphView(data: userProfileViewModel.workoutData)
                Spacer()
                QuickActionsView()
            }
                    .navigationTitle("Home")
                    .padding()
        }.onAppear(){
            Task{
                await userProfileViewModel.loadStats()
            }
        }.alert(item: $userProfileViewModel.errorMessage) { error in
            Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HomeView()
}
