//
//  ProductHomeView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import SwiftUI

struct ProductHomeView: View {
    @StateObject var viewModel = CategoryViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var appTheme: AppTheme
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SearchBar()
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.greeting)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text(userViewModel.currentUser?.firstName ?? "Unknown")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.orange)
                }
                Spacer()
                Image(systemName: "bell.fill")
                    .foregroundStyle(.orange)
                    .padding()
            }
            .padding(.horizontal)
            ScrollView {
                HStack {
                    FeaturedCardView(
                        title: "Recommended Recipe Today",
                        imageName: "dailyrecipe",
                        mealId: "random"
                    )
                    FeaturedCardView(
                        title: "Fresh Delivery",
                        imageName: "freshPicks",
                        mealId: "52772"
                    )
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
                    CategoryView()
                }
            }
            .task {
                await viewModel.fetchData()
            }
        }
        .background(appTheme.backgroundColor)
    }
}
#Preview {
    ProductHomeView()
}
