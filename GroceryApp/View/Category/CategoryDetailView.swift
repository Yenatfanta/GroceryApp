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
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                switch viewModel.viewState {
                case .loaded(let meals):
                    ForEach(meals) { meal in
                        ZStack(alignment: .bottom) {
                            KFImage(URL(string: meal.thumbnail))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                       .stroke(Color.gray, lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 2)
                            Text(meal.name)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.4)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
                                .cornerRadius(8)
                                .padding(8)
                        }
                        .onTapGesture {
                            coordinator
                                .navigate(to: Destination.recipeDetailView(meal.id))
                        }
                        .contentShape(Rectangle())
                    }
                default:
                    Text("view state is: \(viewModel.viewState)")
                }
            }
            .padding(.horizontal)
            .navigationTitle("Meals")
        }
        .task {
            await viewModel.fetchData()
        }
    }
}
