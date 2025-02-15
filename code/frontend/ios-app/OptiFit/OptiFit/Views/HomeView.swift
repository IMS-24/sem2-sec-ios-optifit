//
//  HomeView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI


struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @StateObject var userProfileViewModel = UserProfileViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HeaderView()

                StatisticsView(stats: userProfileViewModel.stats)

                ActivityGraphView(data: viewModel.workoutData)
                Spacer()
                QuickActionsView()
            }
                    .navigationTitle("Home")
                    .padding()
        }.onAppear(){
            userProfileViewModel.loadStats()
        }
    }
}

#Preview {
    HomeView()
}
