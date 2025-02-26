//
//  AuthRepository.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/23/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
protocol AuthRepositoryProtocol {
    func saveUserDetails(userId: String, firstName: String, lastName: String, email: String)
    func getAllUsers(completion: @escaping (Result<[User], Error>) -> Void)
}
final class FirebaseAuthRepository: AuthRepositoryProtocol {
   private init() {}
    let database = Firestore.firestore()
    static let shared = FirebaseAuthRepository()
    func saveUserDetails(userId: String, firstName: String, lastName: String, email: String) {
        // TODO: save user
        database
            .collection("users")
            .document(userId)
            .setData([
                "firstName": firstName,
                "lastName": lastName,
                "email": email
            ]) { error in
                guard let error = error else {
                    print("user saved successfully ")
                    return
                }
                print("error saving user detail: \(error.localizedDescription)")
            }
    }
    func getAllUsers(completion: @escaping (Result<[User], any Error>) -> Void) {
        // TODO: retrieve users
    }
}
