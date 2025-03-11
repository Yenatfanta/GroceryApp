//
//  FirebaseAuthManagerTests.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/5/25.
//

import XCTest
@testable import GroceryApp
// swiftlint: disable all
final class FirebaseAuthManagerTests: XCTestCase {
    var mockAuthService: MockAuthService!
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthService()
    }
    override func tearDown() {
        mockAuthService = nil
        super.tearDown()
    }
    func test_create_account_success() {
        // Given
        let email = "test@gmail.com"
        let password = "password123"
        var result: Result<User, Error>?
        // When
        mockAuthService.createAccount(email: email, password: password) { response in
            result = response
        }
        mockAuthService.completeAccountCreationWithSuccess()
        // Then
        switch result {
        case .success(let user):
            XCTAssertEqual(user.email, email)
            XCTAssertTrue(mockAuthService.createAccountCalled)
        default:
            XCTFail("Expected success, but got failure")
        }
    }
    func test_create_account_failure() {
        // Given
        let email = "test@gmail.com"
        let password = "password123"
        var result: Result<User, Error>?
        let expectedError = TestError(message: "Test error")
        // When
        mockAuthService
            .createAccount(email: email, password: password) { response in
                result = response
            }
        mockAuthService.completeAccountCreationWithError(expectedError)
        // Then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
        default:
            XCTFail("Expected failure, but got success")
        }
    }
}
//swiftlint:enable all
