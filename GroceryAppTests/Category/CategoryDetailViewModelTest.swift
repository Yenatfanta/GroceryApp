//
//  CategoryDetailViewModelTest.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 3/5/25.
//

import XCTest
@testable import GroceryApp
// swiftlint: disable all
final class CategoryDetailViewModelTest: XCTestCase {
    var viewModel: CategoryDetailViewModel!
    var networkManager: MockNetworkManager!
    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        viewModel = CategoryDetailViewModel(
            networkManager: networkManager,
            mealName: ""
        )
    }
    override func tearDown() {
        networkManager = nil
        viewModel = nil
        super.tearDown()
    }
    func createMockResponse() -> MealDetailResponse {
        let mockMealDetail = MealDetail(
            id: "52772",
            name: "Teriyaki Chicken",
            thumbnail: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
        )
        return MealDetailResponse(meals: [mockMealDetail])
    }
    func test_fetch_data_success() async {
        // Given
        networkManager.shouldSucceed = true
        networkManager.mockResponse = createMockResponse()
        // When
        await viewModel.fetchData()
        // Then
        switch viewModel.viewState {
        case .loaded(let mealDetails):
            XCTAssertEqual(mealDetails.count, 1)
            XCTAssertEqual(mealDetails[0].id, "52772")
            XCTAssertEqual(mealDetails[0].name, "Teriyaki Chicken")
            XCTAssertEqual(mealDetails[0].thumbnail, "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")
        default:
            XCTFail("expected view state loaded with meal details")
        }
    }
    func test_fetch_data_failure() async {
        // Given
        networkManager.shouldSucceed = false
        networkManager.mockError = NetworkError.invalidResponse
        // When
        await viewModel.fetchData()
        // Then
        switch viewModel.viewState {
        case .error(let error):
            XCTAssertEqual(
                error,
                networkManager.mockError?.localizedDescription
            )
        default:
            XCTFail("expected view state loaded with meal details")
        }
    }
}
