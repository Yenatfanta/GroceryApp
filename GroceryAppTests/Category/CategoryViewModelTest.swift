//
//  CategoryViewModelTest.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 3/5/25.
//

import XCTest
@testable import GroceryApp
// swiftlint: disable all
final class CategoryViewModelTest: XCTestCase {
    var viewModel: CategoryViewModel!
    var networkManager: MockNetworkManager!
    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        viewModel = CategoryViewModel(networkManager: networkManager)
    }
    override func tearDown() {
        networkManager = nil
        viewModel = nil
        super.tearDown()
    }
    // swiftlint:disable trailing_whitespace
    func createMockResponse() -> CategoryResponse {
        let mockCategory = MealCategory(
            id: "1",
            name: "Beef",
            thumbnail: "https://www.themealdb.com/images/category/beef.png",
            description: """
            Beef is the culinary name for meat from cattle,
            particularly skeletal muscle. Humans have been eating beef since
            prehistoric times.[1] 
            Beef is a source of high-quality protein and essential nutrients.[2]
            """
        )
        return CategoryResponse(categories: [mockCategory])
    }
    // swiftlint:enable trailing_whitespace
    func test_successful_data_fetch() async {
        // Given
        networkManager.shouldSucceed = true
        networkManager.mockResponse = createMockResponse()
        // When
        await viewModel.fetchData()
        // Then
        switch viewModel.viewState {
        case .loaded(let categories):
            XCTAssertEqual(categories.count, 1)
            XCTAssertEqual(categories[0].id, "1")
            XCTAssertEqual(categories[0].name, "Beef")
        default:
            XCTFail("expected loaded case with categories")
        }
    }
}
