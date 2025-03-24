//
//  User.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/25/25.
//

import Foundation
import FirebaseAuth

struct User: Codable, Equatable {
    let userId: String
    let firstName: String?
    let lastName: String?
    let email: String?
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.userId == rhs.userId
    }
}
