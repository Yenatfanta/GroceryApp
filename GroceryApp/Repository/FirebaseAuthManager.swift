//
//  FirebaseAuthManager.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/25/25.
//

import Foundation
import FirebaseAuth
protocol FirebaseAuthManagerProtocol {
    func createAccount(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func getCurrentUser() -> User?
    func signOut(completion: @escaping (Error?) -> Void)
}
final class FirebaseAuthManager: FirebaseAuthManagerProtocol {
    static let shared = FirebaseAuthManager()
    private init() {}
    func createAccount(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authUser = authResult?.user {
                let user = User(
                    userId: authUser.uid,
                    firstName: nil,
                    lastName: nil,
                    email: authUser.email
                )
                completion(.success(user))
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, any Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authUser = authResult?.user {
                let user = User(
                    userId: authUser.uid,
                    firstName: nil,
                    lastName: nil,
                    email: authUser.email
                )
                completion(.success(user))
            }
        }
    }

    func getCurrentUser() -> User? {
        guard let authUser = Auth.auth().currentUser else { return nil }
        return User(
            userId: authUser.uid,
            firstName: nil,
            lastName: nil,
            email: authUser.email
        )
    }

    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
