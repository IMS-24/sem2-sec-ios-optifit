import SwiftUI
import MSAL

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var jwtToken: String = ""
    @State private var showMoreInfo: Bool = false
    
    var body: some View {
        ZStack {
            // Background gradient for a fancy look
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Spacer()
                
                // App Title, Version, and Description
                VStack(spacing: 8) {
                    Text("OptiFit")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Version: TBD")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    Text("Your ultimate fitness companion to track workouts, monitor progress, and get motivated every day!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                
                // Logo
                Image("pepe_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .shadow(radius: 10)
                
                // JWT Token debugging display
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("JWT Token:")
//                        .font(.headline)
//                    TextEditor(text: $jwtToken)
//                        .frame(height: 100)
//                        .padding(4)
//                        .background(Color.white.opacity(0.7))
//                        .cornerRadius(8)
//                        .disabled(true) // Make it read-only
//                }
//                .padding(.horizontal)
                
                // Buttons for Login and More Info
                HStack(spacing: 40) {
                    Button(action: {
                        Task {
                            await viewModel.authorize()
                            // Assume your AuthViewModel stores the JWT token in a property called accessToken.
                            if let token = viewModel.accessToken {
                                jwtToken = token
                                print("JWT Token: \(token)")
                            } else {
                                jwtToken = "No JWT token available"
                            }
                        }
                    }) {
                        Text("Login")
                            .font(.title2)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showMoreInfo = true
                        print("More Info tapped")
                    }) {
                        Text("More Info")
                            .font(.title2)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $showMoreInfo) {
                MoreInfoView()
            }
        }
    }
}

struct MoreInfoView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("More Info")
                .font(.largeTitle)
                .bold()
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
