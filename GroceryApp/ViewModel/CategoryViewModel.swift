//
//  CategoryViewModelFromBase.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import Foundation
final class CategoryViewModel: BaseViewModel<CategoryResponse, [MealCategory]> {
    @Published var greeting: String = ""
    private var storage: DailyMealCategoryManager?
    init(
        networkManager: NetworkManagerProtocol = NetworkManager.shared,
        storage: DailyMealCategoryManager = DailyMealCategoryManager.shared
    ) {
        super.init(networkManager: networkManager,
                   urlProvider: {EndPoint.categories},
                   transform: {$0.categories })
        self.storage = storage
        updateGreeting()
    }
    override func fetchData() async {
        await super.fetchData()
        if case let .loaded(categories) = viewState {
            storage?.updateDailyCategoryIfNeeded(using: categories)
        }
    }
}
 // MARK: - greeting logic
extension CategoryViewModel {
    func updateGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())
        getGreeting(for: hour)
    }
    func getGreeting(for hour: Int) {
        switch hour {
        case 5..<12:
            greeting = "Good Morning"
        case 12..<17:
            greeting = "Good Afternoon"
        case 17..<21:
            greeting =  "Good Evening"
        default:
            greeting = "Good Night"
        }
    }
}
