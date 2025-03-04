//
//  Product.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import Foundation
struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String?
    let category: String
    let imageUrl: String
    let rating: Rating?
    enum CodingKeys: String, CodingKey {
        case id, title, price, description, category, rating
        case imageUrl = "image"
    }
}
struct Rating: Codable {
    let rate: Double
    let count: Int
}
