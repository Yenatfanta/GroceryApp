//
//  AuthViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/25/25.
//

import Foundation
// MARK: - Auth state enum
enum AuthState: Equatable {
    case none
    case loading
    case authenticated(User)
    case error(String)
}
// MARK: - AuthViewModel
final class AuthViewModel: ObservableObject {
    @Published var authState: AuthState = .none
    private let authService: FirebaseAuthManagerProtocol
    // MARK: - Initialization
    init(authService: FirebaseAuthManagerProtocol = FirebaseAuthManager.shared) {
        self.authService = authService
    }
}
// MARK: - Authentication methods
extension AuthViewModel {
    // MARK: - sign in
    func signIn(email: String, password: String) {
        authService
            .signIn(email: email, password: password) { [weak self] result in
                self?.handleAuthResult(result)
            }
    }
    // MARK: - sign out
    func signOut() {
        authService
            .signOut {[weak self] error in
                if let error = error {
                    self?.authState = .error(error.localizedDescription)
                } else {
                    self?.authState = .none
                }
            }
    }
    // MARK: - reset password
    func resetPassword(email: String) {
        authService.resetPassword(email: email) { [weak self] error in
            if let error = error {
                self?.authState =
                    .error("\(error.localizedDescription) email not found")
            }
        }
    }
    // MARK: - helper method
    private func handleAuthResult(_ result: Result<User, Error>) {
        switch result {
        case .success(let user):
            print("logged in: \(user)")
            authState = .authenticated(user)
        case .failure(let error):
            authState = .error(error.localizedDescription)
        }
    }
}
