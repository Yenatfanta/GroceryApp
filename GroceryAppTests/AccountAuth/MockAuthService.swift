//
//  MockAuthService.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 2/26/25.
//

import Foundation
@testable import GroceryApp
// swiftlint: disable all
struct TestError: Error, LocalizedError {
    let message: String
    var errorDescription: String? { message }
}
final class MockAuthService: FirebaseAuthManagerProtocol {
    func resetPassword(email: String, completion: @escaping ((any Error)?) -> Void) {
        
    }

    var shouldSucceed = true
    var mockUser  = User(userId: "123", firstName: "Adam", lastName: "Smith", email: "adam@gmail.com")
    var createAccountCalled = false
    var signInCalled = false
    var signOutCalled = false
    var emailPassed: String?
    var passwordPassed: String?
    var completionToReturn: ((Result<User, Error>) -> Void)?
    var signOutCompletion: ((Error?) -> Void)?
    func createAccount(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<User, Error>) -> Void) {
        createAccountCalled = true
        emailPassed = email
        passwordPassed = password
        completionToReturn = completion
    }
    func completeAccountCreationWithSuccess() {
        mockUser = User(
            userId: "123",
            firstName: "Adam",
            lastName: "Smith",
            email: emailPassed
        )
       // mockUser.password = passwordPassed
        completionToReturn?(.success(mockUser))
    }
    func completeAccountCreationWithError(_ error:
                                          Error = NSError(domain: "test",
                                          code: 0, userInfo:
                                          [NSLocalizedDescriptionKey: "Test error"])) {
        completionToReturn?(.failure(error))
    }
    func signIn(email: String, password: String, completion: @escaping (Result<GroceryApp.User, Error>) -> Void) {
        signInCalled = true
        emailPassed = email
        passwordPassed = password
        completionToReturn = completion
    }
    func completeUserSignInWithSuccess() {
        completionToReturn?(.success(mockUser))
    }
    func completeSignInWithError(_ error:
                                 Error = NSError(domain: "test",
                                 code: 0, userInfo:
                                 [NSLocalizedDescriptionKey: "Test error"])) {
        completionToReturn?(.failure(error))
    }
    func getCurrentUser() -> User? {
        // TODO: mock reading user
        return nil
    }

    func signOut(completion: @escaping ((Error)?) -> Void) {
        signOutCalled = true
        signOutCompletion = completion
    }
    func completeSignOutWithError(_ error:
                                  Error = NSError(domain: "test",
                                  code: 0, userInfo:
                                  [NSLocalizedDescriptionKey: "Test error"])) {
        signOutCompletion?(error)
    }
    func completeSignOutWithSuccess() {
        signOutCompletion?(nil)
    }
}
//swiftlint:enable all
