//
//  CreateAccountViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/25/25.
//

import Foundation
final class CreateAccountViewModel: ObservableObject {
    private let authManager: FirebaseAuthManagerProtocol
    private let repository: AuthRepositoryProtocol
    @Published var authState: AuthState = .none
    init(authManager: FirebaseAuthManagerProtocol = FirebaseAuthManager.shared,
         repository: AuthRepositoryProtocol = FirebaseAuthRepository.shared) {
        self.authManager = authManager
        self.repository = repository
    }
    func createAccount(email: String, password: String, firstName: String, lastName: String) {
        authManager
            .createAccount(email: email, password: password) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    self.repository
                        .saveUserDetails(
                            userId: UUID().uuidString,
                            firstName: firstName,
                            lastName: lastName,
                            email: email
                        )
                    self.authState = .authenticated(user)
                case .failure(let error):
                    self.authState = .error(error.localizedDescription)
                }
            }
    }
}
