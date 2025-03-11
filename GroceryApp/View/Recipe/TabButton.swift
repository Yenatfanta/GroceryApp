//
//  TabButton.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/11/25.
//

import SwiftUI

struct TabButton: View {
    let title: String
    let index: Int
    @Binding var selectedTab: Int
    var body: some View {
        Button {
            withAnimation {
                selectedTab = index
            }
        } label: {
            VStack(spacing: 8) {
                Text(title)
                    .fontWeight(selectedTab == index ? .bold : .medium)
                    .foregroundStyle(selectedTab == index ? .primary : .secondary)
                    .padding(.vertical, 12)
                Rectangle()
                    .fill(selectedTab == index ? Color.orange : Color.clear)
                    .frame(height: 3)
            }
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.plain)
    }
}
