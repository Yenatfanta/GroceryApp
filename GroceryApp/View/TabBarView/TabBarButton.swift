//
//  TabBarButton.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI

struct TabBarButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    var body: some View {
        GeometryReader { geometry in
            Button {
                selectedTab = tab
            } label: {
                VStack {
                    Image(systemName: tabIcon)
                        .font(.system(size: 20))
                        .foregroundStyle(selectedTab == tab ? .orange : .white)
                    if geometry.size.width > 100 {
                        Text(title)
                            .font(.caption)
                            .foregroundStyle(selectedTab == tab ? .orange : .white)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    private var tabIcon: String {
        switch tab {
        case .category: return "square.grid.2x2.fill"
        case .home: return "house.fill"
        case .profile: return "person.fill"
        case .favorite: return "heart.fill"
        case .cart: return "cart.fill"
        }
    }
    private var title: String {
        switch tab {
        case .category: return "Category"
        case .home: return "Home"
        case .profile: return "Profile"
        case .favorite: return "Favorite"
        case .cart: return "Cart"
        }
    }
}
