//
//  ProfileVierw.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 15.02.25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileViewModel:UserProfileViewModel
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        Section(header: Text("Profile")) {
            HStack {
                Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    if let profile = profileViewModel.profile {
                        Text("\(profile.firstName) \(profile.lastName)").font(.headline)
                        Text(profile.email).font(.subheadline).foregroundColor(.gray)

                        if let dob = profile.dateOfBirthUtc {
                            Text("Birthdate: \(dob.formattedDate())").font(.subheadline).foregroundColor(.gray)
                        }
                        if let lastLogin = profile.lastLoginUtc {
                            Text("Last login: \(lastLogin.formattedDate())").font(.subheadline).foregroundColor(.gray)
                        }

                        Text("Registered at: \(profile.registeredUtc?.formattedDate() ?? "N/A")").font(.subheadline).foregroundColor(.gray)
                        Text("Updated at: \(profile.updatedUtc?.formattedDate() ?? "N/A")").font(.subheadline).foregroundColor(.gray)
                        Text("User Role: \(profile.userRole ?? "N/A")").font(.subheadline).foregroundColor(.gray)
                        Text("Initial Setup Done: \(profile.initialSetupDone ? "Yes" : "No")").font(.subheadline).foregroundColor(.gray)
                    } else {
                        Text("Loading ...").font(.headline).font(.subheadline).foregroundColor(.gray)
                        Text("Please wait").font(.subheadline).foregroundColor(.gray).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
            Button("Logout", role: .destructive) {
                authViewModel.signOut()
                //profileViewModel.unsetProfile()
            }
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var userProfileViewModel: UserProfileViewModel {
        let x = UserProfileViewModel()
        x.profile = .init(id: UUID(), firstName: "Johnny", lastName: "Chimpo", email: "dutchmen@gmail.com", initialSetupDone: true)
        return x
    }
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
            .environmentObject(userProfileViewModel)
    }
}
