//
//  FavoritesManager.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import Foundation
protocol FavoritesManagerProtocol {
    func toggleFavorite(recipe: RecipeDetail)
    func isFavorite(_ id: String) -> Bool
    func getAllFavorites() -> [RecipeDetail]
}
final class FavoritesManager: FavoritesManagerProtocol {
    @Published var favorites: [String: RecipeDetail] = [:]
    static let shared = FavoritesManager()
    private let favoritesKey = "savedFavorites"
    private init() {
        loadFavorites()
    }
    func toggleFavorite(recipe: RecipeDetail) {
        if favorites[recipe.id] != nil {
            favorites.removeValue(forKey: recipe.id)
        } else {
            favorites[recipe.id] = recipe
        }
        saveFavorites()
    }
    func isFavorite(_ id: String) -> Bool {
        return favorites[id] != nil
    }
    func getAllFavorites() -> [RecipeDetail] {
        return Array(favorites.values)
    }
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey), let decoded = try? JSONDecoder().decode(
            [String: RecipeDetail].self,
            from: data) {
            favorites = decoded
        }
    }
}
