//
//  CategoryViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import Foundation
final class CategoryViewModel: ObservableObject {
    private var categories: [Category] = []
    private var categoryResponse: CategoryResponse?
    @Published var viewState: ViewState<[Category]> = .none
    @Published var selectedMeal: String = ""
    private let networkManager: NetworkManagerProtocol
    init (networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    @MainActor
    func loadCategories() async {
        viewState = .loading
        do {
            // https://www.themealdb.com/api/json/v1/1/categories.php
            categoryResponse = try await networkManager
                .loadData(url: EndPoint.categories)
            categories = categoryResponse?.categories ?? []
            viewState = .loaded(categories)
        } catch {
            print(error.localizedDescription)
            viewState = .error(error.localizedDescription)
        }
    }
}
