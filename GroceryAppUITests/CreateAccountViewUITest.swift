//
//  CreateAccountViewUITest.swift
//  GroceryAppUITests
//
//  Created by Yenat Feyyisa on 3/5/25.
//

import XCTest
// swiftlint:disable:next trailing_whitespace
final class CreateAccountViewUITest: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCreateAccountViewDisplaysCorrectly() throws {
        app.buttons["Next"].tap()
        app.buttons["Create An Account"].tap()
        XCTAssertTrue(app.textFields["firstNameField"].exists)
        XCTAssertTrue(app.textFields["lastNameField"].exists)
        XCTAssertTrue(app.textFields["emailField"].exists)
        XCTAssertTrue(app.secureTextFields["passwordField"].exists)
        XCTAssertTrue(app.buttons["createAccountButton"].exists)
        XCTAssertTrue(app.scrollViews["createAccountScroll"].exists)
    }
    func testUserCanEnterDetailsAndSubmit() throws {
        app.buttons["Next"].tap()
        app.buttons["Create An Account"].tap()
        let firstNameField = app.textFields["firstNameField"]
        let lastNameField = app.textFields["lastNameField"]
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let confirmPassword = app.secureTextFields["confirmPasswordField"]
        let createAccountButton = app.buttons["createAccountButton"]
        firstNameField.tap()
        firstNameField.typeText("John")
        lastNameField.tap()
        lastNameField.typeText("Doe")
        emailField.tap()
        emailField.typeText("john.doe@example.com")
        passwordField.tap()
        passwordField.typeText("Test1234!55")
        confirmPassword.tap()
        confirmPassword.typeText("Test1234!55")
        confirmPassword.swipeUp()
        createAccountButton.tap()
        let successView = app.otherElements["userCreatedSuccessfully"]
        XCTAssertTrue(successView.waitForExistence(timeout: 10))
    }
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    func testErrorMessageDisplaysForInvalidInput() throws {
        app.buttons["Next"].tap()
        app.buttons["Create An Account"].tap()
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let createAccountButton = app.buttons["createAccountButton"]
        let errorMessage = app.staticTexts["errorMessage"]
            // Enter invalid email and short password
            emailField.tap()
            emailField.typeText("invalidemail")

            passwordField.tap()
            passwordField.typeText("123")

            createAccountButton.tap()

            XCTAssertTrue(errorMessage.waitForExistence(timeout: 3))
        }
}
