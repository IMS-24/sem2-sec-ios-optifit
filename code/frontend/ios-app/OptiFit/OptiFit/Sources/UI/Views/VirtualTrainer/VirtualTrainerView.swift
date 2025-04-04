import SwiftUI

struct VirtualTrainerView: View {
    @StateObject private var viewModel = VirtualTrainerViewModel()

    var body: some View {
        VStack(spacing: 20) {

            Text("🐸 Virtual Trainer")
                .font(.largeTitle)
                .bold()

            Text(viewModel.trainerName)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.green)
                .padding(.vertical, 5)

            Image(getPepeImage(for: viewModel.currentLevel))
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .animation(.easeInOut, value: viewModel.currentLevel)

            if let insult = viewModel.insult {
                VStack(spacing: 10) {
                    Text(insult)
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .font(.system(size: CGFloat(16 + (viewModel.currentLevel <= 25 ? viewModel.currentLevel : 25)), weight: .regular))
                        .transition(.scale)
                        .animation(.easeInOut, value: viewModel.currentLevel)
                }
            } else {
                ProgressView("Fetching insult...")
            }

            Button(action: loadMotivation) {
                Text("🔥 Roast Me")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            loadMotivation()
        }
        .alert(item: $viewModel.errorMessage) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK")))
        }
    }

    func loadMotivation() {
        Task {
            await viewModel.getMotivation()
        }

    }

    private func getPepeImage(for level: Int) -> String {
        let images = ["pepe_1", "pepe_2", "pepe_3", "pepe_4", "pepe_5", "pepe_6", "pepe_7", "pepe_8", "pepe_9"]
        let maxLevel = 25
        let clampedLevel = max(1, min(level, maxLevel))
        let ratio = Double(clampedLevel - 1) / Double(maxLevel - 1)
        let index = Int(round(ratio * Double(images.count - 1)))
        return images[index]
    }

}
