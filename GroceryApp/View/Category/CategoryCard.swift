//
//  CategoryCard.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import SwiftUI
import Kingfisher
struct CategoryCard: View {
    let category: MealCategory
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(URL(string: category.thumbnail ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                       .stroke(Color.gray, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 2)
            Text(category.name)
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
            coordinator.navigate(to: Destination.detailView(category.name))
        }
        .contentShape(Rectangle())
    }
}
