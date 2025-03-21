//
//  MealDetail.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import Foundation
struct MealDetail: Codable, Identifiable {
    let id: String
    let name: String
    let thumbnail: String
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}
struct MealDetailResponse: Codable {
    let meals: [MealDetail]?
}
