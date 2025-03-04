//
//  CategoryViewModelFromBase.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import Foundation
final class CategoryViewModel: BaseViewModel<CategoryResponse, [MealCategory]> {
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        super.init(networkManager: networkManager,
                   urlProvider: {EndPoint.categories},
                   transform: {$0.categories})
    }
}
