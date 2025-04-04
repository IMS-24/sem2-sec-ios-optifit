import SwiftUI

struct MuscleDetailView: View {
    var muscle: Components.Schemas.GetMuscleDto?

    var body: some View {
        Group {
            if let muscle = muscle, let code = muscle.i18NCode, !code.isEmpty {
                ScrollView {
                    VStack(spacing: 20) {
                        // Muscle title
                        Text(code.capitalized)
                            .font(.largeTitle)
                            .bold()

                        MuscleImagesView(muscle: muscle)

                        // Additional details area.
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Muscle Code: \(code)")
                                .font(.subheadline)
                            // Further details can be added here.
                        }
                        .padding()

                        Spacer()
                    }
                    .padding()
                }
            } else {
                // Fallback view when no muscle data exists.
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text("No muscle data available")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
        }
        .navigationTitle("Muscle Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
