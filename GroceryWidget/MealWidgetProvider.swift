//
//  MealWidgetProvider.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/25/25.
//

import Foundation
import WidgetKit

struct MealWidgetProvider: TimelineProvider {
    let suiteName = "techconsulting.GroceryApp"
    let category: String = ""
    func getTimeline(in context: Context, completion: @escaping (Timeline<MealEntry>) -> Void) {
        let entry = MealEntry(date: Date(), category: loadCategory())
       if let nextUpdate = Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Date()) {
           let timeLine = Timeline(entries: [entry], policy: .after(nextUpdate))
           completion(timeLine)
       }
    }
    func getSnapshot(in context: Context, completion: @escaping (MealEntry) -> Void) {
        let entry = MealEntry(date: Date(), category: loadCategory())
        completion(entry)
    }
    func placeholder(in context: Context) -> MealEntry {
        MealEntry(date: Date(), category: "Loading...")
    }
}
struct MealEntry: TimelineEntry {
    let date: Date
    let category: String
}
// MARK: - helper function
extension MealWidgetProvider {
    private func loadCategory() -> String {
        let defaults = UserDefaults(suiteName: suiteName)
        return defaults?.string(forKey: "dailyMealCategory") ?? "No Categories yet"
    }
}
