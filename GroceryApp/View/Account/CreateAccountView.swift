//
//  CreateAccountView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/22/25.
//

import SwiftUI
import Combine
struct CreateAccountView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var userCreatedSuccessfully = false
    @State private var errorMessage: String?
    @State private var user: User?
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = CreateAccountViewModel()
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
                if let error = errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                        .padding(.top)
                }
                Text("By tapping the create account you agree to terms and conditions")
                    .foregroundStyle(.gray)
                    .font(.body)
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    viewModel
                        .createAccount(
                            email: email,
                            password: password,
                            firstName: firstName,
                            lastName: lastName
                        )
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
        .onReceive(viewModel.$authState) { newState in
            switch newState {
            case .authenticated(let userCreated):
                userCreatedSuccessfully = true
                user = userCreated
            case .error(let error):
                errorMessage = error
            default:
                print("sorry user couldn't be created")
            }
        }
        .overlay(
            userCreatedSuccessfully ?
            UserCreatedView(userCreatedSuccessfully: $userCreatedSuccessfully, user: $user)
                          .transition(.opacity.combined(with: .scale))
                          .animation(.spring(), value: userCreatedSuccessfully)
            : nil
        )
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
