import SwiftUI

struct WorkoutTrackingTimerView: View {
    var elapsedTime: TimeInterval
    var body: some View {

        HStack {
            Spacer()
            HStack(spacing: 4) {
                Image(systemName: "stopwatch")
                    .foregroundColor(Color(.primaryAccent))
                Text(elapsedTimeString)
                    .font(.headline)
                    .foregroundColor(Color(.primaryAccent))
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
    var elapsedTimeString: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
