//
//  Category.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import Foundation
struct MealCategory: Codable, Identifiable {
    let id: String
    let name: String
    let thumbnail: String?
    let description: String?
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnail = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
struct CategoryResponse: Codable {
    let categories: [MealCategory]
}
