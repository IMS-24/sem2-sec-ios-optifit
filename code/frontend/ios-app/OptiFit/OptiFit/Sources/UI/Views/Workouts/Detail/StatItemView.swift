import SwiftUI

struct StatItemView: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(Color(.primaryAccent))
            Text(value)
                .font(.headline)
                .foregroundColor(Color(.primaryText))
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 80.0, height: 80.0)
    }
}
#Preview {
    StatItemView(icon: "person.circle", title: "Stat", value: "666")
}
