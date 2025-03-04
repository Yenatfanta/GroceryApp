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
        VStack {
            switch viewModel.viewState {
            case .loaded(let recipes):
                ForEach(recipes) { recipe in
                    RecipeCard(recipe: recipe)
                }
            default:
                Text("view state: \(viewModel.viewState)")
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }
}
#Preview {
    RecipeDetailView(mealId: "5535")
}
