//
//  CreateAccountView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/22/25.
//

import SwiftUI
struct CreateAccountView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        VStack {
            ZStack {
                Image("veggies")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
            }
            VStack(alignment: .leading, spacing: 20) {
                Text("Create Your Account")
                    .font(.title2)
                    .fontWeight(.bold)
                HStack {
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(CustomTextFieldStyle())
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(CustomTextFieldStyle())

                }
                TextField("Email", text: $email)
                    .textFieldStyle(CustomTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(CustomTextFieldStyle())
                Text("By tapping the create account you agree to terms and conditions")
                    .foregroundStyle(.gray)
                    .font(.body)
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    // coordinator.navigate(to: Destination.joinPage)
                } label: {
                    Text("CREATE AN ACCOUNT")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.orange)
                        .cornerRadius(25)
                        .padding(.horizontal, 40)
                        .shadow(radius: 5)
                }

            }
            .padding()
            .background(Color.white)
            .cornerRadius(25, corners: [.topLeft, .topRight])
        }
    }
}
struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner ) -> some View {
        clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
struct CustomTextFieldStyle: TextFieldStyle {
    // swiftlint:disable:next identifier_name
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .autocapitalization(.none)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.orange.opacity(0.3), lineWidth: 1)
            )
    }
}
#Preview {
    CreateAccountView()
        .environmentObject(Coordinator())
}
