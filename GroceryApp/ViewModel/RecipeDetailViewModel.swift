//
//  RecipeDetailViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import Foundation
final class RecipeDetailViewModel: BaseViewModel<RecipeDetailResponse, [RecipeDetail]> {
    let mealId: String
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, mealId: String) {
        self.mealId = mealId
        EndPoint.mealId = mealId
        super.init(networkManager: networkManager,
                   urlProvider: {EndPoint.recipeDetail},
                   transform: {$0.meals})
    }
}
