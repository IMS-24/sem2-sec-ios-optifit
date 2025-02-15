//
//  StatCardView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct StatCardView: View {
    var stat: Stat

    var body: some View {
        VStack {
            Text("\(stat.value)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

            Text(stat.title)
                    .font(.caption)
                    .foregroundColor(.gray)
        }
                .frame(width: 100, height: 80)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 2)
    }
}

#Preview {
    StatCardView(stat: Stat(title: "Test", value: 10))
}
