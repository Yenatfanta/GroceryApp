//
//  BaseViewModelTest.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import XCTest
@testable import GroceryApp

final class BaseViewModelTest: XCTestCase {
    var networkManager: MockNetworkManager!
    var viewModel: BaseViewModel<CategoryResponse, [MealCategory]>!
    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        viewModel = BaseViewModel(
            networkManager: networkManager,
            urlProvider: {"test.url"},
            transform: {$0.categories})
    }
    override func tearDown() {
        networkManager = nil
        viewModel = nil
        super.tearDown()
    }
    func createMockResponse() -> CategoryResponse {
        let mockCategory = MealCategory(
            id: "1",
            name: "Beef",
            thumbnail: "https://www.themealdb.com/images/category/beef.png",
            description: """
            Beef is the culinary name for meat from cattle,
            particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] 
            Beef is a source of high-quality protein and essential nutrients.[2]
            """
        )
        return CategoryResponse(categories: [mockCategory])
    }
    func test_initial_view_state() {
        switch viewModel.viewState {
        case .none:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected initial state to be none")
        }
    }
    func test_category_view_model_fetch_data_success() async {
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
            XCTFail("Expected loaded state with categories")
        }
    }
    func test_category_view_model_fetch_data_failure() async {
        // Given
        networkManager.shouldSucceed = false
        networkManager.mockError = NetworkError.unknown
        // When
        await viewModel.fetchData()
        // Then
        switch viewModel.viewState {
        case .error(let error):
            XCTAssertEqual(error, networkManager.mockError?.localizedDescription)
        default:
            XCTFail("Expected error state with error")
        }
    }
}
