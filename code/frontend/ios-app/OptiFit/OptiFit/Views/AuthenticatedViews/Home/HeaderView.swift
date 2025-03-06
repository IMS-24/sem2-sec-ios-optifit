//
//  HeaderView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("ApplicationName")
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
