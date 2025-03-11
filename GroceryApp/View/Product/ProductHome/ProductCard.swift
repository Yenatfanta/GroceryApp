//
//  ProductCard.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import SwiftUI
import Kingfisher
struct ProductCard: View {
    var product: Product
    var body: some View {
        VStack {
            KFImage(URL(string: product.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .cornerRadius(12)
            Text(product.title)
                .font(.headline)
                .fontWeight(.bold)
            Text("\(product.price)")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
        .frame(width: 160)
    }
}
