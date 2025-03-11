//
//  FeaturedCardView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import Foundation
import SwiftUI
struct FeaturedCardView: View {
    var title: String?
    var imageName: String?
    let mealId: String
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(imageName ?? "")
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 100)
                .cornerRadius(12)
            Text(title ?? "")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(6)
                .background(Color.black.opacity(0.3))
                .cornerRadius(6)
                .padding(6)
        }
        .onTapGesture {
            coordinator.navigate(to: Destination.recipeDetailView(mealId))
        }
    }
}
