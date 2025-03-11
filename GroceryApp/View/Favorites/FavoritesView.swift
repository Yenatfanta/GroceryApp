//
//  FavoritesView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = FavoritesViewModel()
    var body: some View {
        TwoColumnGrid(title: "Favorites") {
            if viewModel.getAllFavorites().isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No Favorites Yet")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("Recipes you mark as favorites will appear here")
                        .font(.body)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .frame(maxWidth: .infinity, minHeight: 300)
            } else {
                ForEach(viewModel.getAllFavorites()) { recipe in
                    FoodCard(
                        title: recipe.name,
                        imageUrl: recipe.thumbnail,
                        action: {
                            coordinator
                                .navigate(
                                    to: Destination.recipeDetailView(recipe.id))
                        }
                    )
                    .overlay(
                        FavoriteButton(recipe: recipe)
                            .padding(8),
                        alignment: .topTrailing
                    )
                }
            }
        }
    }
}
#Preview {
    FavoritesView()
        .environmentObject(Coordinator())
}
