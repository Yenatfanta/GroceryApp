//
//  ResetPasswordView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/20/25.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @FocusState private var focusedField: Field?
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appTheme: AppTheme
    @ObservedObject var viewModel: AuthViewModel
    @State private var isLoading = false
    @Environment(\.dismiss) private var dismiss
    @State private var showSuccessCheck: Bool = false
    @State var alertMessage: String = ""
    enum Field {
        case email
    }
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                        Text("Back to Login")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                }
                .padding(.top, 16)
                Text("Reset Your Password")
                    .font(.system(size: 28, weight: .bold))
                Text("Enter your email address and we'll send you a link to reset your password.")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
                    .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            AuthTextField(title: "Email",
                          placeholder: "email",
                          text: $email,
                          keyboardtype: .emailAddress,
                          submitLabel: .done,
                          onSubmit: {
                            if !email.isEmpty {
                                initiatePasswordReset()
                                }
                            },
                          focusState: $focusedField,
                          field: .email)
            AuthButton(title: "Reset Password",
                       action: initiatePasswordReset,
                       isLoading: isLoading
            )
            .disabled(email.isEmpty)
            .opacity(email.isEmpty ? 0.7 : 1)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Password Reset"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
        )
        .padding(.horizontal, 24)
        if showSuccessCheck {
            successOverlay
        }
    }
    private var successOverlay: some View {
        Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 80, height: 80)
                        Image(systemName: "checkmark")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Text("Reset Link sent")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Check your email for instructions to reset your password.")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        Text("Return to Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                }
                    .padding(32)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                    )
                    .padding(32)
                    .transition(.opacity.combined(with: .scale))
            )
            .transition(.opacity)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Password Reset"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
    func initiatePasswordReset() {
        viewModel.resetPassword(email: email)
        switch viewModel.authState {
        case .error(let error):
            alertMessage = error
            showAlert = true
        default:
            withAnimation(.spring()) {
                showSuccessCheck = true
            }
        }
    }
}
#Preview {
    ResetPasswordView(viewModel: AuthViewModel())
        .environmentObject(Coordinator())
        .environmentObject(AppTheme())
}
