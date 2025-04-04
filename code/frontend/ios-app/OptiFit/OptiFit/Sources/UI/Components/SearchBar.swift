import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = ""

    var body: some View {
        HStack {
            TextField("Search \(placeholder) ...", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}

#Preview {
    SearchBar(text: .constant(""), placeholder: "Gyms")
}
