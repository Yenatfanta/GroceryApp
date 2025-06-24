//
//  GroceryWidget.swift
//  GroceryWidget
//
//  Created by Yenat Feyyisa on 3/25/25.
//

import WidgetKit
import SwiftUI
struct GroceryWidgetEntryView: View {
    var entry: MealEntry

    var body: some View {
        VStack {
            Text("Today's Meal")
                .font(.headline)

            Text(entry.category)
                .font(.title)
                .bold()
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct GroceryWidget: Widget {
    let kind = "MealWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MealWidgetProvider()) { entry in
               GroceryWidgetEntryView(entry: entry)
           }
           .configurationDisplayName("Daily Meal Category")
           .description("Shows one meal category per day.")
           .supportedFamilies([.systemSmall, .systemMedium])
       }
}

#Preview(as: .systemSmall) {
    GroceryWidget()
} timeline: {
    MealEntry(date: .now, category: "😀")
    MealEntry(date: .now, category: "🤩")
}
