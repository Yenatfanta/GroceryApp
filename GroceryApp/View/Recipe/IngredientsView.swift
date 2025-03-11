//
//  IngredientsView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/11/25.
//

import SwiftUI

struct IngredientsView: View {
    let ingredients: [IngredientMeasure]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(ingredients) { ingredient in
                HStack(alignment: .center) {
                    Text("•")
                        .foregroundColor(.orange)
                        .font(.title2)
                    Text(ingredient.ingredient)
                        .fontWeight(.medium)
                    Spacer()
                    Text(ingredient.measure)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                Divider()
                    .padding(.leading)
            }
        }
        .accessibilityIdentifier("ingredientsList")
    }
}
