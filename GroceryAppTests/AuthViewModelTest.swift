//
//  AuthViewModelTest.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 2/26/25.
//

import XCTest
@testable import GroceryApp
final class AuthViewModelTest: XCTestCase {
    var viewModel: AuthViewModel!
    var mockAuthRepository: MockAuthRepository!
    var mockAuthManager: MockAuthService!
    override func setUp() {
        super.setUp()
        mockAuthManager = MockAuthService()
        mockAuthRepository = MockAuthRepository()
        viewModel = AuthViewModel(authService: mockAuthManager)
    }
    override func tearDown() {
        mockAuthManager = nil
        mockAuthRepository = nil
        viewModel = nil
        super.tearDown()
    }
    func test_initial_state() {
        XCTAssertEqual(viewModel.authState, .none)
    }
    func test_signIn_calls_auth_manager() {
      // Given
        let email = "adam@gmail.com"
        let password = "password123"
        let firstName = "Adam"
        let lastName = "Smith"
        // When
        viewModel.signIn(email: email, password: password)
        // Then
        XCTAssertTrue(mockAuthManager.signInCalled)
        XCTAssertEqual(mockAuthManager.emailPassed, email)
        XCTAssertEqual(mockAuthManager.passwordPassed, password)
    }
    func test_signIn_success_updates_auth_state() {
        // Given
          let email = "adam@gmail.com"
          let password = "password123"
          let firstName = "Adam"
          let lastName = "Smith"
          // When
          viewModel.signIn(email: email, password: password)
          mockAuthManager.completeUserSignInWithSuccess()
        // Then
        switch viewModel.authState {
        case .authenticated(let user):
            XCTAssertNotNil(user)
        default:
            XCTFail("Expected authenticated state but got \(viewModel.authState)")
        }
    }
    func test_signIn_failure_updates_auth_state() {
        // Given
          let email = "adam@gmail.com"
          let password = "password123"
          let firstName = "Adam"
          let lastName = "Smith"
        let testError = TestError(message: "Account creation failed")
          // When
          viewModel.signIn(email: email, password: password)
        mockAuthManager.completeSignInWithError(testError)
        // Then
        switch viewModel.authState {
        case .error(let error):
            XCTAssertEqual(error, testError.localizedDescription)
        default:
            XCTFail("Expected authenticated state but got \(viewModel.authState)")
        }
    }
    func test_sign_out_calls_auth_manager() {
        // when
        viewModel.signOut()
        // Then
        XCTAssertTrue(mockAuthManager.signOutCalled)
    }
    func test_sign_out_success_updates_auth_state() {
        // when
        viewModel.signOut()
        mockAuthManager.completeSignOutWithSuccess()
        // Then
        XCTAssertEqual(viewModel.authState, .none)
    }
    func test_sign_out_failure_updates_auth_state() {
        // Given
        let testError = NSError(domain: "auth", code: 500, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        // When
        viewModel.signOut()
        mockAuthManager.completeSignOutWithError(testError)
        // Then
        switch viewModel.authState {
        case .error(let error):
            XCTAssertEqual(error, testError.localizedDescription)
        default:
            XCTFail("Expected authenticated state but got \(viewModel.authState)")
        }
    }
}
