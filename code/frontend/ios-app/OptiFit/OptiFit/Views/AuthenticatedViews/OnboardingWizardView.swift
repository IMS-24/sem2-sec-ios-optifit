import SwiftUI

struct OnboardingWizardView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var userProfileViewModel: UserProfileViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    // Create computed bindings for each field. They use a default profile if needed.
    private var firstNameBinding: Binding<String> {
        Binding(
            get: { userProfileViewModel.profile?.firstName ?? "" },
            set: { newValue in
                var profile = userProfileViewModel.profile ?? UserProfileDto(
                    id: UUID(),
                    firstName: "",
                    lastName: "",
                    email: "",
                    userRole: nil,
                    dateOfBirthUtc: Date(),
                    lastLoginUtc: nil,
                    registeredUtc: nil,
                    updatedUtc: nil,
                    initialSetupDone: false
                )
                profile.firstName = newValue
                userProfileViewModel.profile = profile
            }
        )
    }
    
    private var lastNameBinding: Binding<String> {
        Binding(
            get: { userProfileViewModel.profile?.lastName ?? "" },
            set: { newValue in
                var profile = userProfileViewModel.profile ?? UserProfileDto(
                    id: UUID(),
                    firstName: "",
                    lastName: "",
                    email: "",
                    userRole: nil,
                    dateOfBirthUtc: Date(),
                    lastLoginUtc: nil,
                    registeredUtc: nil,
                    updatedUtc: nil,
                    initialSetupDone: false
                )
                profile.lastName = newValue
                userProfileViewModel.profile = profile
            }
        )
    }
    
    private var emailBinding: Binding<String> {
        Binding(
            get: { userProfileViewModel.profile?.email ?? "" },
            set: { newValue in
                var profile = userProfileViewModel.profile ?? UserProfileDto(
                    id: UUID(),
                    firstName: "",
                    lastName: "",
                    email: "",
                    userRole: nil,
                    dateOfBirthUtc: Date(),
                    lastLoginUtc: nil,
                    registeredUtc: nil,
                    updatedUtc: nil,
                    initialSetupDone: false
                )
                profile.email = newValue
                userProfileViewModel.profile = profile
            }
        )
    }
    
    private var dateOfBirthBinding: Binding<Date> {
        Binding(
            get: { userProfileViewModel.profile?.dateOfBirthUtc ?? Date() },
            set: { newValue in
                var profile = userProfileViewModel.profile ?? UserProfileDto(
                    id: UUID(),
                    firstName: "",
                    lastName: "",
                    email: "",
                    userRole: nil,
                    dateOfBirthUtc: Date(),
                    lastLoginUtc: nil,
                    registeredUtc: nil,
                    updatedUtc: nil,
                    initialSetupDone: false
                )
                profile.dateOfBirthUtc = newValue
                userProfileViewModel.profile = profile
            }
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Welcome!")) {
                    Text("Please provide your details")
                        .font(.headline)
                }
                
                Section(header: Text("First Name")) {
                    TextField("Enter your first name", text: firstNameBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Last Name")) {
                    TextField("Enter your last name", text: lastNameBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Email")) {
                    TextField("Enter your email", text: emailBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Birth Date")) {
                    DatePicker("Select your birth date", selection: dateOfBirthBinding, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                }
                
                Section {
                    Button("Continue") {
                        completeOnboarding()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    Button("Cancel"){
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Onboarding")
        }
    }
    
    private func completeOnboarding() {
        Task {
            // Call your update function using the (now updated) profile from the view model.
            if let profile = userProfileViewModel.profile {
                let updatedProfile = UpdateUserProfileDto(firstName: profile.firstName, lastName: profile.lastName, email: profile.email, dateOfBirthUtc: profile.dateOfBirthUtc, initialSetupDone: true)
                await userProfileViewModel.updateProfile(profileToUpdate: updatedProfile)
            }
        }
    }
}

struct OnboardingWizardView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a default profile for preview.
        let viewModel = UserProfileViewModel()
        viewModel.profile = UserProfileDto(
            id: UUID(),
            firstName: "",
            lastName: "",
            email: "",
            userRole: nil,
            dateOfBirthUtc: Date(),
            lastLoginUtc: nil,
            registeredUtc: nil,
            updatedUtc: nil,
            initialSetupDone: false
        )
        return OnboardingWizardView()
            .environmentObject(viewModel)
    }
}
