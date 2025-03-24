//
//  FavoritesViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import Foundation
import Combine
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: [String: RecipeDetail] = [:]
    var cancellables = Set<AnyCancellable>()
//    private var favoritesManager: FavoritesManagerProtocol
//   
//    init(favoritesManager: FavoritesManagerProtocol = FavoritesManager.shared) {
//        self.favoritesManager = favoritesManager
//    }
//    func toggleFavorite(recipe: RecipeDetail) {
//        favoritesManager.toggleFavorite(recipe: recipe)
//        objectWillChange.send()
//    }
//    func isFavorite(_ id: String) -> Bool {
//        favoritesManager.isFavorite(id)
//    }
//    func getAllFavorites() -> [RecipeDetail] {
//        favoritesManager.getAllFavorites()
//    }
    private var favoritesManagerFB: FireStoreFavoritesManagerProtocol
    init(favoritesManagerFB: FireStoreFavoritesManagerProtocol = FireStoreFavoritesManager()) {
        self.favoritesManagerFB = favoritesManagerFB
        bindToManager()
    }
    private func bindToManager() {
        (favoritesManagerFB as? FireStoreFavoritesManager)?.$favorites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newFavorites in
                self?.favorites = newFavorites
            }
            .store(in: &cancellables)
    }
    func toggleFavorite(recipe: RecipeDetail) async {
            do {
                try await favoritesManagerFB.toggleFavorite(recipe: recipe)
            } catch {
                print(error.localizedDescription)
            }
    }
    func isFavorite(_ id: String) async -> Bool {
            do {
                return try await favoritesManagerFB.isFavorite(id)
            } catch {
                print(error.localizedDescription)
                return false
            }
    }
    func getAllFavorites() async -> [RecipeDetail] {
        do {
            return try await favoritesManagerFB.getAllFavorites()
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
