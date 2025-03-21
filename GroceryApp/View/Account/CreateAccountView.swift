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
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var userCreatedSuccessfully = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var user: User?
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = CreateAccountViewModel()
    enum Field: Hashable {
        case firstName, lastName, email, password, confirmPassword
    }
    var body: some View {
//        Text("Creaye account")
        ScrollView {
            VStack(spacing: 0) {
                Image("veggies")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                VStack(alignment: .leading, spacing: 24) {
                    Text("CREATE YOUR ACCOUNT")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    Group {
                        VStack(spacing: 16) {
                            HStack {
                                AuthTextField(
                                    title: "First Name",
                                    placeholder: "",
                                    text: $firstName,
                                    submitLabel: .next,
                                    onSubmit: {focusedField = .lastName },
                                    focusState: $focusedField,
                                    field: .firstName
                                )
                                .accessibilityIdentifier(
                                    CreateAccountId.firstNameField)
                                AuthTextField(
                                    title: "Last Name",
                                    placeholder: "",
                                    text: $lastName,
                                    submitLabel: .next,
                                    onSubmit: {focusedField = .email },
                                    focusState: $focusedField,
                                    field: .lastName
                                )
                                .accessibilityIdentifier(
                                    CreateAccountId.lastNameField
                                )
                            }
                            AuthTextField(
                                title: "Email",
                                placeholder: "example@email.com",
                                text: $email,
                                keyboardtype: .emailAddress,
                                submitLabel: .next,
                                onSubmit: {focusedField = .password },
                                focusState: $focusedField,
                                field: .email
                            )
                            .accessibilityIdentifier(
                                CreateAccountId.emailField
                            )
                            AuthPasswordField(
                                title: "Password",
                                placeholder: "At least 8 characters",
                                text: $password,
                                isVisible: $isPasswordVisible,
                                submitLabel: .next,
                                onSubmit: {focusedField = .confirmPassword},
                                focusedState: $focusedField,
                                field: .password
                            )
                            .accessibilityIdentifier(
                                CreateAccountId.passwordField
                            )
                            AuthPasswordField(
                                title: "Confirm Password",
                                placeholder: "Confirm password",
                                text: $confirmPassword,
                                isVisible: $isPasswordVisible,
                                submitLabel: .next,
                                onSubmit: {focusedField = .confirmPassword},
                                focusedState: $focusedField,
                                field: .confirmPassword
                            )
                            .accessibilityIdentifier(
                                CreateAccountId.confirmPasswordField)
                        }
                    }
                    if let error = errorMessage {
                        AuthErrorMessage(message: error)
                            .accessibilityIdentifier(
                                CreateAccountId.errorMessage
                            )
                    }
                    Group {
                    Text("By tapping Create Account, you agree to our [Terms of Service](terms) and [Privacy Policy](privacy)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 16)
                    AuthButton(
                        title: "Create Account",
                        action: {
                            viewModel
                                .createAccount(
                                    email: email,
                                    password: password,
                                    firstName: firstName,
                                    lastName: lastName
                                )
                        },
                        isLoading: isLoading)
                    .padding(.top, 20)
                    .accessibilityIdentifier(
                        CreateAccountId.createAccountButton
                    )
                }
                    AuthNavigationLink(
                        question: "Already have an account?",
                        linkText: "Sign In",
                        action: { dismiss() }
                    )
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color(UIColor.systemBackground))
        .accessibilityIdentifier(
            CreateAccountId.createAccountScroll
        )
        .toolbar {
            KeyBoardToolBar {
                focusedField = nil
            }
        }
        .onReceive(viewModel.$authState) { newState in
            switch newState {
            case .authenticated(let userCreated):
                isLoading = false
                userCreatedSuccessfully = true
                user = userCreated
                print("view user \(user)")
            case .none:
                isLoading = false
            case .loading:
                isLoading = true
            case .error(let error):
                isLoading = false
                errorMessage = error
            }
        }
        .overlay(
            userCreatedSuccessfully ?
            UserCreatedView(userCreatedSuccessfully: $userCreatedSuccessfully, user: $user)
                           .transition(.opacity.combined(with: .scale))
                           .animation(.spring(), value: userCreatedSuccessfully)
                           .accessibilityIdentifier(CreateAccountId.userCreatedSuccessfully)
            : nil
        )
    }
}
#Preview {
    CreateAccountView()
        .environmentObject(Coordinator())
}
