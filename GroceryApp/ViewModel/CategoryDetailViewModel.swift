//
//  CategoryDetailViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import Foundation
import Combine
final class CategoryDetailViewModel: ObservableObject {
    private var meals: [MealDetail] = []
    @Published var viewState: ViewState<[MealDetail]> = .none
    private let networkManager: NetworkManagerProtocol
    private let categoryViewModel = CategoryViewModel()
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    @MainActor
    func loadDetail(_ mealName: String) async {
        viewState = .loading
        do {
            EndPoint.categoryName = mealName
            let detailResponse: MealDetailResponse = try await networkManager
                .loadData(url: EndPoint.categoryDetail)
            meals = detailResponse.meals ?? []
            viewState = .loaded(meals)
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }
}
