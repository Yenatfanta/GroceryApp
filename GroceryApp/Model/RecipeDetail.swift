//
//  RecipeDetail.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import Foundation
struct RecipeDetail: Codable, Identifiable {
    let id: String
    let name: String
    let origin: String
    let instructions: String
    let thumbnail: String
    let youtube: String?
    let category: String?
    let ingredients: [IngredientMeasure]
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case origin = "strArea"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case youtube = "strYoutube"
        case category = "strCategory"
    }
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        origin = try container.decode(String.self, forKey: .origin)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        youtube = try container.decode(String.self, forKey: .youtube)
        category = try container.decode(String.self, forKey: .category)
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var ingredientArray: [IngredientMeasure] = []
        var index = 1
        while true {
            let ingredientKey = DynamicCodingKeys(key: "strIngredient\(index)")
            let measureKey = DynamicCodingKeys(key: "strMeasure\(index)")
            if dynamicContainer.contains(ingredientKey) && dynamicContainer.contains(measureKey) {
                if let ingredient = try dynamicContainer.decodeIfPresent(
                    String.self,
                    forKey: ingredientKey),
                   let measure = try dynamicContainer.decodeIfPresent(
                    String.self,
                    forKey: measureKey),
                   !ingredient
                    .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                   !measure
                    .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    ingredientArray
                        .append(IngredientMeasure(ingredient: ingredient, measure: measure))
                }
            } else {
                break
            }
            index += 1
        }
        ingredients = ingredientArray
    }
}
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    init(key: String) {
        stringValue = key
    }
    var intValue: Int? { nil }
    init?(intValue: Int) {
        nil
    }
}
struct IngredientMeasure: Identifiable {
    let id = UUID().uuidString
    let ingredient: String
    let measure: String
}
struct RecipeDetailResponse: Codable {
    let meals: [RecipeDetail]
}
