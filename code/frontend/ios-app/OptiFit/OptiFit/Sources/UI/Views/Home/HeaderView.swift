import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        HStack {
            // Use email if available; if not, use name; if still nil, show "No user"
            Text(viewModel.user?.emails?.first ?? viewModel.user?.name ?? viewModel.user?.id.uuidString ?? "No user")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            Spacer()

            Button(action: {
                print("Profile tapped")
            }) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
//
//struct HeaderViewWrapper: View {
//
//    let viewModel = AuthViewModel(authService: MockAuthService())
//
//    var body: some View {
//        HeaderView()
//            .environmentObject(viewModel)
//    }
//}
//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderViewWrapper()
//    }
//}
