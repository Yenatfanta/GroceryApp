//
//  FavoritesViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import Foundation
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: [String: RecipeDetail] = [:]
    private var favoritesManager: FavoritesManagerProtocol
    init(favoritesManager: FavoritesManagerProtocol = FavoritesManager.shared) {
        self.favoritesManager = favoritesManager
    }
    func toggleFavorite(recipe: RecipeDetail) {
        favoritesManager.toggleFavorite(recipe: recipe)
        objectWillChange.send()
    }
    func isFavorite(_ id: String) -> Bool {
        favoritesManager.isFavorite(id)
    }
    func getAllFavorites() -> [RecipeDetail] {
        favoritesManager.getAllFavorites()
    }
}
