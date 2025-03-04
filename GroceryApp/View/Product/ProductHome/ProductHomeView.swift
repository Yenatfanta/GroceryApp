//
//  ProductHomeView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import SwiftUI

struct ProductHomeView: View {
    @StateObject var viewModel = ProductViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Good Morning")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Text("Mohammed")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Image(systemName: "bell.fill")
                        .foregroundStyle(.orange)
                        .padding()
                }
                .padding(.horizontal)
                HStack {
                    FeaturedCardView(title: "Recommended Recipe Today", imageName: "dailyrecipe")
                    FeaturedCardView(title: "Fresh Delivery", imageName: "freshPicks")
                }
                .padding(.horizontal)
                VStack {
                    HStack {
                        Text("Trending Deals")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal)
                    LazyVGrid(columns: columns, spacing: 10) {
                        switch viewModel.viewState {
                        case .loaded(let products):
                            ForEach(products) { product in
                                ProductCard(product: product)
                            }
                        default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .task {
           // print("in task...")
            await viewModel.loadProducts()
        }
    }
}

#Preview {
    ProductHomeView()
}
