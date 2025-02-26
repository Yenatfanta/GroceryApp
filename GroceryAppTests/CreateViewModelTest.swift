//
//  CreateViewModelTest.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 2/26/25.
//

import XCTest
@testable import GroceryApp
final class CreateViewModelTest: XCTestCase {
    var viewModel: CreateAccountViewModel!
    var mockAuthManager: MockAuthService!
    var mockAuthRepository: MockAuthRepository!
    override func setUp() {
        super.setUp()
        mockAuthManager = MockAuthService()
        mockAuthRepository = MockAuthRepository()
        viewModel = CreateAccountViewModel(authManager: mockAuthManager, repository: mockAuthRepository)
    }

    override func tearDown() {
        mockAuthManager = nil
        mockAuthRepository = nil
        viewModel = nil
        super.tearDown()
    }
    func test_create_account_success() {
        mockAuthManager.shouldSucceed = true
        viewModel.createAccount(email: "123", password: "Adam", firstName: "Smith", lastName: "adam@gmail.com")
    }
    func test_initial_state() {
        XCTAssertEqual(viewModel.authState, .none)
    }
    func test_create_account_calls_auth_manager() {
        // Given
        let email = "test@example.com"
        let password = "password123"
        let firstName = "John"
        let lastName = "Doe"
        // When
        viewModel
            .createAccount(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName
            )
        // Then
        XCTAssertTrue(mockAuthManager.createAccountCalled)
        XCTAssertEqual(mockAuthManager.emailPassed, email)
        XCTAssertEqual(mockAuthManager.passwordPassed, password)
    }
    func test_create_account_success_saves_user_detail_called() {
        // Given
        let email = "test@example.com"
        let password = "password123"
        let firstName = "John"
        let lastName = "Doe"
        // When
        viewModel
            .createAccount(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName
            )
        mockAuthManager.completeAccountCreationWithSuccess()
        // Then
        XCTAssertTrue( mockAuthRepository.saveUserDetailsCalled)
        XCTAssertNotNil(mockAuthRepository.userIdPassed)
        XCTAssertEqual(mockAuthRepository.firstNamePassed, firstName)
        XCTAssertEqual(mockAuthRepository.lastNamePassed, lastName)
        XCTAssertEqual(mockAuthRepository.emailPassed, email)
    }
    func test_create_account_success_updates_authState() {
        // Given
        let email = "test@example.com"
        let password = "password123"
        let firstName = "John"
        let lastName = "Doe"
        // When
        viewModel
            .createAccount(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName
            )
        mockAuthManager.completeAccountCreationWithSuccess()
        // Then
        switch viewModel.authState {
        case .authenticated(let user):
            XCTAssertNotNil(user)
        default:
            XCTFail("Expected authenticated state but got \(viewModel.authState)")
        }
    }
    func test_create_account_failure_updates_authState() {
        // Given
        let email = "test@example.com"
        let password = "password123"
        let firstName = "John"
        let lastName = "Doe"
        let testError = TestError(message: "Account creation failed")
        // When
        viewModel
            .createAccount(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName
            )
        mockAuthManager.completeAccountCreationWithError(testError)
        // Then
        switch viewModel.authState {
        case .error(let error):
            XCTAssertEqual(error, testError.localizedDescription)
        default:
            XCTFail("Expected error state but got \(viewModel.authState)")
        }
    }
    func test_account_create_failure_fails_save_user_details() {
        // Given
        let email = "test@example.com"
        let password = "password123"
        let firstName = "John"
        let lastName = "Doe"
        // When
        viewModel
            .createAccount(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName
            )
        mockAuthManager.completeAccountCreationWithError()
        // Then
        XCTAssertFalse(mockAuthRepository.saveUserDetailsCalled)
    }
}
