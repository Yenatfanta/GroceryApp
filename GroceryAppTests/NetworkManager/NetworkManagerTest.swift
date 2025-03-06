//
//  NetworkManagerTest.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 3/5/25.
//

import XCTest
@testable import GroceryApp

// swiftlint: disable all
final class NetworkManagerTest: XCTestCase {
    var networkManager: NetworkManager!
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSession.self]
        let session = URLSession(configuration: configuration)
        networkManager = NetworkManager(session: session)
    }

    override func tearDown() {
        networkManager = nil
        MockURLSession.responseData = nil
        MockURLSession.responseError = nil
        MockURLSession.statusCode = 200
        MockURLSession.mockResponse = nil
        super.tearDown()
    }
    func test_load_data_successful() async throws {
        // Given
        let mockData = """
               {
                   "meals": [
                       {
                           "idMeal": "52772",
                           "strMeal": "Teriyaki Chicken",
                           "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
                       }
                   ]
               }
               """.data(using: .utf8)!
        MockURLSession.responseData = mockData
        MockURLSession.statusCode = 200
        MockURLSession.responseError = nil
        // When
        let result: MealDetailResponse = try await networkManager.loadData(
            url: "https://mockapi.com/meals")
        XCTAssertNotNil(result.meals)
        XCTAssertEqual(result.meals?[0].name, "Teriyaki Chicken")
        XCTAssertEqual(result.meals?[0].thumbnail, "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")
    }
    func test_load_data_invalid_url() async {
        do {
            // when
            let _: MealDetailResponse = try await networkManager.loadData(url: "invalidUrl")
            XCTFail("expected invalid url error but got success")
        } catch APIServiceError.invalidURL {
            // Then
            XCTAssertTrue(true)
        } catch {
            XCTFail("expected invalid url error but got different error")
        }
    }
    func test_load_data_invalid_url_empty_string() async {
        do {
            // when
            let _: MealDetailResponse = try await networkManager.loadData(url: "")
            XCTFail("expected invalid url error but got success")
        } catch APIServiceError.invalidURL {
            // Then
            XCTAssertTrue(true)
        } catch {
            XCTFail("expected invalid url error but got different error")
        }
    }
    func test_load_data_server_error() async {
        // Given
        MockURLSession.statusCode = 500
        MockURLSession.responseData = nil
        MockURLSession.responseError = nil
        do {
            // When
            let _: MealDetailResponse = try await networkManager.loadData(url: "https://mockapi.com/meals")
            XCTFail("expected invalid url error but got success")
        } catch APIServiceError.responseError(let statusCode) {
            // Then
            XCTAssertEqual(statusCode, 500)
        } catch {
            XCTFail("expected invalid error")
        }
    }
    func test_load_data_invalid_response() async {
        // Given
        MockURLSession.statusCode = 200
        MockURLSession.responseData = "invalid-json".data(using: .utf8)
        MockURLSession.responseError = nil
        // When
        do {
            let _: MealDetailResponse = try await networkManager.loadData(url: "https://mockapi.com/meals")
                       XCTFail("Expected decoding error but got success")
        } catch {
            // Then
            XCTAssertTrue(error is DecodingError)
        }
    }
    func test_load_data_invalid_response_not_http() async {
        // Given: A response that is NOT HTTPURLResponse
        MockURLSession.mockResponse = URLResponse(
            url: URL(string: "https://mockapi.com")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        let mockData = """
               {
                   "meals": [
                       {
                           "idMeal": "52772",
                           "strMeal": "Teriyaki Chicken",
                           "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
                       }
                   ]
               }
               """.data(using: .utf8)!
        MockURLSession.responseData = mockData
        
        do {
            let _: MealDetailResponse = try await networkManager.loadData(url: "https://mockapi.com")
            XCTFail("Expected invalidResponse error but got success")
        } catch APIServiceError.invalidResponse {
            XCTAssertTrue(true)
        } catch {
            XCTFail("Expected invalidResponse error but got different error: \(error)")
        }
    }
}
