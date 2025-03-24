//
//  FireStoreFavoritesManager.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/19/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
protocol FireStoreFavoritesManagerProtocol {
    func toggleFavorite(recipe: RecipeDetail) async throws
    func isFavorite(_ id: String) async throws -> Bool 
    func getAllFavorites() async throws -> [RecipeDetail]
}
final class FireStoreFavoritesManager {
    @Published var favorites: [String: RecipeDetail] = [:]
    private let database = Firestore.firestore()
    private var userId: String = ""
     init() {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        self.userId = currentUserId
        fetchFavorites()
    }
}
// MARK: - managing favorites
extension FireStoreFavoritesManager: FireStoreFavoritesManagerProtocol {
    func toggleFavorite(recipe: RecipeDetail) async throws {
        let recipeDoc = database
            .collection("users")
            .document(userId)
            .collection("favorites")
            .document(recipe.id)
        if favorites[recipe.id] != nil {
            favorites.removeValue(forKey: recipe.id)
            try await recipeDoc.delete()
        } else {
            favorites[recipe.id] = recipe
            try recipeDoc.setData(from: recipe)
        }
    }

    func isFavorite(_ id: String) async throws -> Bool {
        favorites[id] != nil
    }

    func getAllFavorites() async throws -> [RecipeDetail] {
        Array(favorites.values)
    }

}
// MARK: - fetching favorites from fireStore
extension FireStoreFavoritesManager {
    func fetchFavorites() {
        let favoritesDoc = database
            .collection("users")
            .document(userId)
            .collection("favorites")
        favoritesDoc.getDocuments { [weak self] snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching favorites: \(error?.localizedDescription ?? "")")
                return
            }
            var fetchedFavorites: [String: RecipeDetail] = [:]
            documents.forEach { document in
                if let recipe = try? document.data(as: RecipeDetail.self) {
                    fetchedFavorites[recipe.id] = recipe
                }
            }
            DispatchQueue.main.async {
                self?.favorites = fetchedFavorites
            }
        }
    }
}
// MARK: - user not found error
enum UserError: Error {
    case userNotFound
}
