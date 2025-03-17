//
//  RecipeCardViewTest.swift
//  GroceryAppUITests
//
//  Created by Yenat Feyyisa on 3/5/25.
//

import XCTest
//swiftlint:disable all
final class RecipeCardViewTest: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }
    // swiftlint:disable line_length
    func test_recipe_detail_view_scrollview_did_appear() {
        app.buttons["Next"].tap()
        app.buttons["Login"].tap()
        app.buttons["LOG IN"].tap()
        app.buttons["Category"].tap()

        let element = app.scrollViews.children(matching: .other).element(boundBy: 0).children(
            matching: .other
        ).element
        element.children(matching: .image).element(boundBy: 2).swipeUp()
        XCTAssertTrue(element.exists)
    }
    // swiftlint:enable line_length
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
//swiftlint:enable all
