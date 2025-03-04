//
//  APIService.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import Foundation
protocol NetworkManagerProtocol {
    func loadData<T: Codable> (url: String) async throws -> T
}
final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private init() {}
    func loadData<T: Codable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIServiceError.invalidURL
        }
       let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw APIServiceError.invalidResponse
        }
        guard (200...299).contains(response.statusCode) else {
            throw APIServiceError.responseError(response.statusCode)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
enum APIServiceError: Error {
    case invalidURL, invalidResponse, responseError(Int)
}
