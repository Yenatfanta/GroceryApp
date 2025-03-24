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
    @State var isFavorite: Bool = false
    var body: some View {
        Button {
            withAnimation {
                isFavorite.toggle()
                Task {
                     await viewModel.toggleFavorite(recipe: recipe)
                    isFavorite = await viewModel.isFavorite(recipe.id)
                }
            }
        } label: {
            Label(
                isFavorite ? "Liked" : "Like",
                systemImage: isFavorite ? "heart.fill" : "heart"
            )
            .font(.subheadline.bold())
            .foregroundStyle(
                isFavorite ? .white : .orange)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                isFavorite ?
                            Color.orange :
                            Color.orange.opacity(0.15)
                        )
            .clipShape(Capsule())
        }
        .task {
            isFavorite = await viewModel.isFavorite(recipe.id)
        }
        .onChange(of: viewModel.favorites[recipe.id]) {
            Task {
                isFavorite = await viewModel.isFavorite(recipe.id)
            }
        }
    }
}
