//
//  MockAuthRepository.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 2/26/25.
//

import Foundation
@testable import GroceryApp
final class MockAuthRepository: AuthRepositoryProtocol {
    var saveUserDetailsCalled = false
    var userIdPassed: String?
    var firstNamePassed: String?
    var lastNamePassed: String?
    var emailPassed: String?
    func saveUserDetails(userId: String, firstName: String, lastName: String, email: String) {
        saveUserDetailsCalled = true
        userIdPassed = userId
        firstNamePassed = firstName
        lastNamePassed = lastName
        emailPassed = email
    }

    func getAllUsers(completion: @escaping (Result<[GroceryApp.User], any Error>) -> Void) {
        
    }
}
