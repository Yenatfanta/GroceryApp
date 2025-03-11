//
//  FavoriteButton.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI

struct FavoriteButton: View {
    let recipe: RecipeDetail
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = FavoritesViewModel()
  
    var body: some View {
        Button {
            viewModel.toggleFavorite(recipe: recipe)
        } label: {
            Label(
                viewModel.isFavorite(recipe.id) ? "Saved" : "Save",
                systemImage: viewModel.isFavorite(recipe.id) ? "heart.fill" : "heart"
            )
            .font(.subheadline.bold())
            .foregroundStyle(
                viewModel.isFavorite(recipe.id) ? .white : .orange)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                viewModel.isFavorite(recipe.id) ?
                            Color.orange :
                            Color.orange.opacity(0.15)
                        )
            .clipShape(Capsule())
        }
    }
}
