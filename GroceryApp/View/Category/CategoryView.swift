//
//  CategoryView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import SwiftUI
struct CategoryView: View {
    @StateObject var viewModel = CategoryViewModel()
    @EnvironmentObject var appTheme: AppTheme
    @EnvironmentObject var coordinator: Coordinator
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        TwoColumnGrid(title: "Categories") {
            ViewStateContainer(viewState: viewModel.viewState) { categories in
                ForEach(categories) { category in
                    FoodCard(title: category.name,
                             imageUrl: category.thumbnail ?? "",
                             action: {
                        coordinator
                            .navigate(to: Destination.detailView(category.name))
                    })
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .task {
            await viewModel.fetchData()
        }
        .background(appTheme.backgroundColor)
    }
}
#Preview {
    CategoryView()
}
