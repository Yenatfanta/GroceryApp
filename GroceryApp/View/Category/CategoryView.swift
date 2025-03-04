//
//  CategoryView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import SwiftUI
struct CategoryView: View {
    @EnvironmentObject var viewModel: CategoryViewModel
    @EnvironmentObject var coordinator: Coordinator
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                switch viewModel.viewState {
                case .loaded(let categories):
                    ForEach(categories) { category in
                        CategoryCard(category: category)
                    }
                default:
                    Text("view state is: \(viewModel.viewState)")
                }
            }
            .navigationTitle("Categories")
            .padding(.horizontal)
        }
        .task {
            await viewModel.loadCategories()
        }
    }
}
#Preview {
    CategoryView()
}
