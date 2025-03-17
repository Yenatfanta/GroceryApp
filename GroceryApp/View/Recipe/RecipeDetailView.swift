//
//  RecipeDetailView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject var viewModel: RecipeDetailViewModel
    let mealId: String
    init(mealId: String) {
        self.mealId = mealId
        _viewModel = StateObject(
            wrappedValue: RecipeDetailViewModel(mealId: mealId)
        )
    }
    var body: some View {
        ZStack {
            ViewStateContainer(viewState: viewModel.viewState,
                               content: { recipes in
                if let recipe = recipes.first {
                    RecipeCard(recipe: recipe)
                }
            }, loadingView: {
                ProgressView("Loading recipe...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }, errorView: {
                ErrorStateView(message: "Unable to load recipe") {
                    Task {
                        await viewModel.fetchData()
                    }
                }
                .transition(.opacity)
            }
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
        .task {
            await viewModel.fetchData()
        }
    }
}
#Preview {
    RecipeDetailView(mealId: "5535")
}
