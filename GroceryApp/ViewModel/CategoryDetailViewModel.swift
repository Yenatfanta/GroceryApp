//
//  CategoryDetailViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import Foundation

final class CategoryDetailViewModel: BaseViewModel<MealDetailResponse, [MealDetail]> {
    let mealName: String
    // MARK: -  initialization
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, mealName: String) {
        self.mealName = mealName
        EndPoint.categoryName = mealName
        super.init(networkManager: networkManager,
                   urlProvider: {EndPoint.categoryDetail},
                   transform: {$0.meals ?? []})
    }
}
