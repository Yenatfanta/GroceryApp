//
//  DailyMealCategoryManager.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/25/25.
//

import Foundation
import WidgetKit
final class DailyMealCategoryManager {
    // MARK: - Properties
    private let suiteName = "techconsulting.GroceryApp"
    private let categoryKey = "dailyMealCategory"
    private let dateKey = "lastStoredDate"
    // MARK: - Initialization
    static let shared = DailyMealCategoryManager()
    private init(){}
}
// MARK: - Managing Daily Category
extension DailyMealCategoryManager {
    func updateDailyCategoryIfNeeded(using categories: [MealCategory]) {
        let today = formattedDate()
        let defaults = UserDefaults(suiteName: suiteName)
        let lastSaved = defaults?.string(forKey: dateKey)
        guard lastSaved != today else {
            print("already updated for today")
            return
        }
        if let randomCategory = categories.randomElement() {
            defaults?.set(randomCategory.name, forKey: categoryKey)
            defaults?.set(today, forKey: dateKey)
            WidgetCenter.shared.reloadAllTimelines()
            print("🎯 Stored daily category: \(randomCategory)")
        }
    }
}
// MARK:-  Helper functions
extension DailyMealCategoryManager {
    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
