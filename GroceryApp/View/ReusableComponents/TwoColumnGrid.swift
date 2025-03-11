//
//  TwoColumnGrid.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI

struct TwoColumnGrid<Content: View>: View {
    let content: Content
    let title: String
    let horizontalPadding: Bool
    init(title: String, horizontalPadding: Bool = true, @ViewBuilder content: () -> Content) {
        self.title = title
        self.horizontalPadding = horizontalPadding
        self.content = content()
    }
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                content
            }
            .navigationTitle(title)
            .padding(.horizontal, horizontalPadding ? 16 : 0)
        }
    }
}
