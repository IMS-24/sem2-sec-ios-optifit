//
//  HeaderView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        HStack {
            // Use email if available; if not, use name; if still nil, show "No user"
            Text(viewModel.user?.email ?? viewModel.user?.name ?? viewModel.user?.id.uuidString ?? "No user")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Spacer()
            
            Button(action: {
                print("Profile tapped")
            }) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}


#Preview {
    HeaderView()
}
