//
//  WelcomePage.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct WelcomePage: View {
    let appTitle: String
    let appVersion: String

    var iconName: String {

        return "dumbbell.fill"

    }
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color.gray.opacity(0.2))

                Image(systemName: iconName)
                        .resizable()
                        .frame(width: 100, height: 100)
            }

            HStack {


                Text(appTitle)
                        .font(.headline)

            }
                    .padding()

            Text(appVersion)
                    .font(.caption)
        }
                .padding()
    }
}

#Preview {
    WelcomePage(appTitle: "AppName", appVersion: "v.1.0.0-beta")
}
