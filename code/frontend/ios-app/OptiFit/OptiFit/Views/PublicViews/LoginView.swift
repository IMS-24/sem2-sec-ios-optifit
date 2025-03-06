import SwiftUI
import MSAL

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                Text(viewModel.loggingText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .border(Color.gray)
            .frame(height: 200)
            
            Button("Authorize") {
                Task {
                    await viewModel.authorize()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("Refresh Token") {
                Task {
                    await viewModel.refreshToken()
                }
            }
            .padding()
            .background(viewModel.refreshTokenEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(!viewModel.refreshTokenEnabled)
            
            Button("Call API") {
                Task {
                    await viewModel.callApi()
                }
            }
            .padding()
            .background(viewModel.callGraphApiEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(!viewModel.callGraphApiEnabled)
            
            Button("Sign Out") {
                viewModel.signOut()
            }
            .padding()
            .background(viewModel.signOutEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(!viewModel.signOutEnabled)
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
