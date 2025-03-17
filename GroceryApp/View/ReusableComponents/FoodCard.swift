//
//  FoodCard.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI
import Kingfisher

struct FoodCard: View {
    let title: String
    let imageUrl: String
    let action: () -> Void
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            StyledKFImage(urlString: imageUrl)
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                //.padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.4)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(8)
                //.padding(8)
        }
        .onTapGesture(perform: action)
        .contentShape(Rectangle())
    }
}
struct StyledKFImage: View {
    let urlString: String
    var body: some View {
        KFImage(URL(string: urlString))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 2)
    }
}
