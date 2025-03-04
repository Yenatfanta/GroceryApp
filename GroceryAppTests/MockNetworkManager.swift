//
//  MockDataManager.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import Foundation
@testable import GroceryApp

class MockNetworkManager: NetworkManagerProtocol {
    var shouldSucceed: Bool
    var mockResponse: Codable?
    var mockError: Error?
    init(shouldSucceed: Bool = true, mockResponse: Codable? = nil, mockError: Error? = nil) {
        self.mockError = mockError
        self.mockResponse = mockResponse
        self.shouldSucceed = shouldSucceed
    }
    func loadData<T: Codable>(url: String) async throws -> T {
        if !shouldSucceed {
            throw mockError ?? NetworkError.unknown
        }
        guard let response = mockResponse as? T else {
            throw NetworkError.invalidResponse
        }
        return response
    }
}
enum NetworkError: Error {
    case unknown
    case invalidResponse
}
