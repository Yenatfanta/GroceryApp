//
//  CreateAccountViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/25/25.
//

import Foundation
import Combine
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
            .createAccount(email: email,
                           password: password,
                           firstName: firstName,
                           lastName: lastName) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    self.repository
                        .saveUserDetails(
                            userId: user.userId,
                            firstName: user.firstName ?? "N/A",
                            lastName: user.lastName ?? "N/A",
                            email: user.email ?? "N/A"
                        )
                    self.authState = .authenticated(user)
//                    print("view model: \(user)")
                case .failure(let error):
                    self.authState = .error(error.localizedDescription)
                }
            }
    }
}
