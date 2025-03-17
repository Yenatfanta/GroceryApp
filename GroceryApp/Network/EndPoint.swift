//
//  EndPoint.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import Foundation
struct EndPoint {
    static let endpoint = "https://fakestoreapi.com/products"
    static let categories = "https://www.themealdb.com/api/json/v1/1/categories.php"
    static var categoryName = "Seafood"
    static var categoryDetail: String {
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(categoryName)"
    }
    static var mealId: String = "52772"
    static var recipeDetail: String {
        mealId == "random" ? "https://www.themealdb.com/api/json/v1/1/random.php" :
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
    }
}
