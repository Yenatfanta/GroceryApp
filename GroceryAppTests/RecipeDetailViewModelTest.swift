//
//  RecipeDetailViewModelTest.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 3/5/25.
//

import XCTest
@testable import GroceryApp
// swiftlint: disable all
final class RecipeDetailViewModelTest: XCTestCase {
    var networkManager: MockNetworkManager!
    var viewModel: RecipeDetailViewModel!
    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        viewModel = RecipeDetailViewModel(
            networkManager: networkManager,
            mealId: "52772")
    }
    override func tearDown() {
        networkManager = nil
        viewModel = nil
        super.tearDown()
    }
    // swiftlint:disable line_length
    func createMockJson() -> Data {
        let jsonString = """
        {
            "meals": [
                {
                    "idMeal": "52772",
                    "strMeal": "Teriyaki Chicken",
                    "strArea": "Japanese",
                    "strInstructions": "1. Cut chicken into bite-sized pieces.\\n2. Mix soy sauce, sugar, and mirin in a bowl.\\n3. Cook chicken in a pan and add sauce.\\n4. Simmer until thickened and serve with rice.",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                    "strYoutube": "https://www.youtube.com/watch?v=4aZr5hZXP_s",
                    "strCategory": "Chicken",
                    "strIngredient1": "Chicken",
                    "strMeasure1": "200g",
                    "strIngredient2": "Soy Sauce",
                    "strMeasure2": "2 tbsp",
                    "strIngredient3": "Sugar",
                    "strMeasure3": "1 tbsp",
                    "strIngredient4": "Mirin",
                    "strMeasure4": "2 tbsp",
                    "strIngredient5": "Rice",
                    "strMeasure5": "To serve"
                }
            ]
        }
        """
        return Data(jsonString.utf8)
    }
    // swiftlint:enable line_length
    func test_decoding_recipe_detail() throws {
        // Given
        let decoder = JSONDecoder()
        // When
        let response = try decoder.decode(RecipeDetailResponse.self, from: createMockJson())
        // Then
        XCTAssertEqual(response.meals.count, 1)
        let recipe = response.meals.first!
        XCTAssertEqual(recipe.id, "52772")
        XCTAssertEqual(recipe.name, "Teriyaki Chicken")
        XCTAssertEqual(recipe.origin, "Japanese")
        XCTAssertEqual(recipe.ingredients.count, 5)
        XCTAssertEqual(recipe.ingredients[0].ingredient, "Chicken")
    }
    func test_fetch_recipe_detail_success() async {
        // Given: Mock a valid API response
        let mockData = createMockJson()
        let mockResponse = try? JSONDecoder().decode(RecipeDetailResponse.self, from: mockData)
        networkManager.mockResponse = mockResponse
        // When: Fetch data
        await viewModel.fetchData()
        // Then: Validate ViewModel updates correctly
        switch viewModel.viewState {
        case .loaded(let recipes):
            XCTAssertEqual(recipes.count, 1)
            XCTAssertEqual(recipes.first?.id, "52772")
            XCTAssertEqual(recipes.first?.name, "Teriyaki Chicken")
            XCTAssertEqual(recipes.first?.origin, "Japanese")
        default:
            XCTFail("Expected .loaded state but got \(viewModel.viewState)")
        }
    }
    func test_fetch_recipe_detail_failure() async {
        // Given: Simulate a network failure
        networkManager.shouldSucceed = false
        networkManager.mockError = NetworkError.invalidResponse
        // When: Fetch data
        await viewModel.fetchData()
        // Then: Expect error state
        switch viewModel.viewState {
        case .error(let message):
            XCTAssertFalse(message.isEmpty, "Error message should not be empty")
        default:
            XCTFail("Expected .error state but got \(viewModel.viewState)")
        }
    }
}
//swiftlint:enable all
