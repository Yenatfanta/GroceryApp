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
    func getCurrentUser(completion: @escaping (User?) -> Void)
}
final class FirebaseAuthRepository: AuthRepositoryProtocol {
    private init() {}
    let database = Firestore.firestore()
    static let shared = FirebaseAuthRepository()
    func saveUserDetails(userId: String, firstName: String, lastName: String, email: String) {
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
    func getCurrentUser(completion: @escaping (User?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(nil)
            return
        }
        let documentReference = database.collection("users")
            .document(currentUser.uid)
        documentReference.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                let user = User(userId: currentUser.uid,
                                 firstName: data?["firstName"] as? String,
                                 lastName: data?["lastName"] as? String,
                                 email: currentUser.email)
                completion(user)
            } else {
                print("User document not found: \(error?.localizedDescription ?? "unknown error")")
            }
        }
    }
}
