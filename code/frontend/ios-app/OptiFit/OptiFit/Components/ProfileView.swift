//
//  ProfileVierw.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct ProfileView: View {
    let profile: UserProfile?

    var body: some View {
        Section(header: Text("Profile")) {
            HStack {
                Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    if let profile = profile {
                        Text("\(profile.firstName) \(profile.lastName)").font(.headline)
                        Text(profile.email).font(.subheadline).foregroundColor(.gray)

                        if let dob = profile.dateOfBirthUtc {
                            Text("Birthdate: \(dob.formattedDate())").font(.subheadline).foregroundColor(.gray)
                        }
                        if let lastLogin = profile.lastLoginUtc {
                            Text("Last login: \(lastLogin.formattedDate())").font(.subheadline).foregroundColor(.gray)
                        }

                        Text("Registered at: \(profile.registeredUtc.formattedDate())").font(.subheadline).foregroundColor(.gray)
                        Text("Updated at: \(profile.updatedUtc.formattedDate())").font(.subheadline).foregroundColor(.gray)
                        Text("User Role: \(profile.userRole)").font(.subheadline).foregroundColor(.gray)
                        Text("Initial Setup Done: \(profile.initialSetupDone ? "Yes" : "No")").font(.subheadline).foregroundColor(.gray)
                    } else {
                        Text("Loading ...").font(.headline).font(.subheadline).foregroundColor(.gray)
                        Text("Please wait").font(.subheadline).foregroundColor(.gray).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
            Button("Logout", role: .destructive) {
                // Handle Logout
            }
        }
    }
}

#Preview {
    ProfileView(profile: UserProfile(
            id: UUID(),
            firstName: "First",
            lastName: "Last",
            email: "first@last.com",
            userRole: "Admin",
            dateOfBirthUtc: Calendar.current.date(byAdding: .year, value: -30, to: Date()),
            lastLoginUtc: Calendar.current.date(byAdding: .day, value: -5, to: Date()),
            registeredUtc: Calendar.current.date(byAdding: .day, value: -12, to: Date())!,
            updatedUtc: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            initialSetupDone: true)
    )
}
