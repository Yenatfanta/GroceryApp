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
}
/*
 enum RecipeEndpoint: Endpoint {
     case recipesList(category: String)
     case recipeDetails(id: String)
     var urlString: String {
         switch self {
         case .recipesList(let category):
             return "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
         case .recipeDetails(let id):
             return "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
         }
     }
 }
 */
