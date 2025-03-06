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
                dataNotLoadedView
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }
    private var dataNotLoadedView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundStyle(.orange)
            Text("Oops something went wrong")
                .font(.title2)
                .fontWeight(.bold)
            Button {
                Task {
                    await viewModel.fetchData()
                }
            } label: {
                Text("Try Again")
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
#Preview {
    RecipeDetailView(mealId: "5535")
}
