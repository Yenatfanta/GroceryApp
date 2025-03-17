//
//  LoginView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/23/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var isLoading = false
    @State private var errorMessage: String?
    @FocusState private var focusedField: Field?
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = AuthViewModel()
    enum Field: Hashable {
        case email, password
    }
    var body: some View {
        VStack(spacing: 0) {
            Image("food")
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
            VStack(spacing: 24) {
                AuthTextField(title: "Email",
                              placeholder: "email",
                              text: $email,
                              keyboardtype: .emailAddress,
                              submitLabel: .next,
                              onSubmit: {focusedField = .password},
                              focusState: $focusedField,
                              field: .email)
                AuthPasswordField(
                    title: "Password",
                    placeholder: "password",
                    text: $password,
                    isVisible: $isPasswordVisible,
                    submitLabel: .done,
                    onSubmit: validateAndSignIn,
                    focusedState: $focusedField,
                    field: .password
                )
                Button {
                     
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .foregroundStyle(.orange)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top, -8)
                Spacer()
                if let error = errorMessage {
                    AuthErrorMessage(message: error)
                }
                AuthButton(
                    title: "LOG IN",
                    action: validateAndSignIn,
                    isLoading: isLoading
                )
                AuthNavigationLink(
                    question: "Don't have an account?",
                    linkText: "Create Account",
                    action: { coordinator.navigate(to: Destination.createAccount) }
                )
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .background(Color.white)
            .frame(maxHeight: .infinity)
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        .toolbar {
            KeyBoardToolBar {
                focusedField = nil
            }
        }
    }
    private func validateAndSignIn() {
        coordinator.navigate(to: Destination.productTab)
    }
}
#Preview {
    LoginView()
        .environmentObject(Coordinator())
}
