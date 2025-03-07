import SwiftUI

struct VirtualTrainerView: View {
    @StateObject private var viewModel = VirtualTrainerViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🐸 Virtual Trainer")
                .font(.title)
                .bold()
            
            // Pepe Image based on current level
            Image(getPepeImage(for: viewModel.currentLevel))
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .animation(.easeInOut, value: viewModel.currentLevel) // Smooth transition
            
            if let insult = viewModel.insult {
                Text(insult)
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    .transition(.scale) // Smooth text transition
            } else {
                ProgressView("Fetching insult...")
            }
            
            Button(action: {
                Task { await viewModel.getMotivation(token: authViewModel.accessToken!) }
            }) {
                Text("🔥 Roast Me")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            Task { await viewModel.getMotivation(token: authViewModel.accessToken!) }
        }
    }
    
    // Function to return the appropriate Pepe meme image
    private func getPepeImage(for level: Int) -> String {
        switch level {
        case 1...2: return "pepe_1" // Neutral Pepe
        case 3...4: return "pepe_2" // Slightly Annoyed Pepe
        case 5...6: return "pepe_3" // Angry Pepe
        case 7...8: return "pepe_4" // Very Angry Pepe
        case 8...9: return "pepe_5"
        case 9...10: return "pepe_6"
        case 10...11: return "pepe_7"
        case 11...12: return "pepe_8"
        default: return "pepe_9"     // Furious Pepe
        }
    }
}
