//
//  CategoryDetailView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import SwiftUI
import Kingfisher
struct CategoryDetailView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var selectedMeal: String
    @StateObject var viewModel: CategoryDetailViewModel
    init(selectedMeal: String) {
        self.selectedMeal = selectedMeal
        _viewModel = StateObject(wrappedValue: CategoryDetailViewModel(mealName: selectedMeal))
    }
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        TwoColumnGrid(title: "Meals") {
            ViewStateContainer(viewState: viewModel.viewState) { meals in
                ForEach(meals) { meal in
                    FoodCard(
                        title: meal.name,
                        imageUrl: meal.thumbnail,
                        action: {
                            coordinator
                                .navigate(
                                    to: Destination.recipeDetailView(meal.id)
                                )
                        }
                    )
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .task {
            await viewModel.fetchData()
        }
    }
}
