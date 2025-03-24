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
    @EnvironmentObject var appTheme: AppTheme
    @State var loginSuccessful: Bool = false
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showResetPassword: Bool = false
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
                    showResetPassword = true
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
            .frame(maxHeight: .infinity)
        }
        .onReceive(viewModel.$authState) { newState in
            switch newState {
            case .authenticated(let user):
                loginSuccessful = true
               
            case .error(let error):
                errorMessage = error
            default:
                print("login not successful")
            }
        }
        .background(appTheme.backgroundColor)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        .toolbar {
            KeyBoardToolBar {
                focusedField = nil
            }
        }
        .overlay(
            showResetPassword ? ResetPasswordView(viewModel: viewModel)
            : nil
        )
    }
    private func validateAndSignIn() {
        viewModel.signIn(email: email, password: password)
        if case .authenticated(let user) = viewModel.authState {
            coordinator.navigate(to: Destination.productTab)
        }
    }
}
#Preview {
    LoginView()
        .environmentObject(Coordinator())
        .environmentObject(AppTheme())
        .environmentObject(UserViewModel())
}
