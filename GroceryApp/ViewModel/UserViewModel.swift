//
//  UserViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/18/25.
//

import Foundation
final class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    private var userRepo: AuthRepositoryProtocol
    init(userRepo: AuthRepositoryProtocol = FirebaseAuthRepository.shared) {
        self.userRepo = userRepo
        updateUser()
    }
    func updateUser() {
        userRepo.getCurrentUser { user in
            self.currentUser = user
        }
    }
}
