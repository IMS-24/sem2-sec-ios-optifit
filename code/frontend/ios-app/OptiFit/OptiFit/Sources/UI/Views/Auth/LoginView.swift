import MSAL
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var jwtToken: String = ""
    @State private var showMoreInfo: Bool = false
    @State private var showEnvInfo: Bool = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Glass card
                VStack(spacing: 16) {
                    Image("pepe_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .shadow(radius: 10)
                    
                    Text(AppConfiguration.appName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                    
                    Text("Your ultimate fitness companion to track workouts, monitor progress, and stay motivated.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primaryText.opacity(0.9))
                        .padding(.horizontal)
                    
                    // Show/hide environment info
                    Button(action: {
                        withAnimation {
                            showEnvInfo.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: showEnvInfo ? "chevron.up.circle" : "chevron.down.circle")
                            Text(showEnvInfo ? "Hide Build Info" : "Show Build Info")
                        }
                        .font(.subheadline)
                        .foregroundColor(.primaryText.opacity(0.85))
                        .padding(.top, 4)
                    }
                    
                    if showEnvInfo {
                        VStack(alignment: .leading, spacing: 6) {
                            Group {
                                InfoRow(label: "Git Hash", value: AppConfiguration.gitHash)
                                InfoRow(label: "Branch", value: AppConfiguration.gitBranch)
                                InfoRow(label: "Version", value: AppConfiguration.fullSemVersion)
                                InfoRow(label: "Environment", value: AppConfiguration.Environment)
                            }
                        }
                        .padding(12)
                        .background(Color.primaryText.opacity(0.1))
                        .cornerRadius(12)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(24)
                .shadow(radius: 10)
                .padding(.horizontal)
                
                // Buttons
                HStack(spacing: 20) {
                    GradientButton(title: "Login", gradient: Gradient(colors: [Color.blue, Color.purple])) {
                        Task {
                            await viewModel.authorize()
                            if let token = viewModel.accessToken {
                                jwtToken = token
                                print("JWT Token: \(token)")
                            } else {
                                jwtToken = "No JWT token available"
                            }
                        }
                    }
                    
                    GradientButton(title: "More Info", gradient: Gradient(colors: [Color.gray, Color.black])) {
                        showMoreInfo = true
                        print("More Info tapped")
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .sheet(isPresented: $showMoreInfo) {
                MoreInfoView()
            }
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(label):")
                .fontWeight(.semibold)
                .foregroundColor(.primaryText)
            Spacer()
            Text(value)
                .foregroundColor(.primaryText.opacity(0.9))
                .lineLimit(1)
                .truncationMode(.middle)
        }
    }
}

struct GradientButton: View {
    let title: String
    let gradient: Gradient
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding(.vertical, 12)
                .frame(minWidth: 100)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .foregroundColor(.white)
                .cornerRadius(14)
                .shadow(radius: 5)
        }
    }
}

struct MoreInfoView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("More Info")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            Text("Welcome to OptiFit, your ultimate fitness companion. Track workouts, monitor progress, and get motivated every day!")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
