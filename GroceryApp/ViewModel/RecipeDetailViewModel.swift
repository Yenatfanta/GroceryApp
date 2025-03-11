//
//  RecipeDetailViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import Foundation
final class RecipeDetailViewModel: BaseViewModel<RecipeDetailResponse, [RecipeDetail]> {
    let mealId: String
    var url: String
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, mealId: String) {
        self.mealId = mealId
        if mealId == "random" {
            url = EndPoint.recipeDetail
        } else {
            url = EndPoint.recipeDetail
        }
        EndPoint.mealId = mealId
        super.init(networkManager: networkManager,
                   urlProvider: {EndPoint.recipeDetail},
                   transform: {$0.meals})
    }
}
