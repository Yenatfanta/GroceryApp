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
        Button {
            selectedTab = tab
        } label: {
            VStack {
                Image(systemName: tabIcon)
                    .font(.system(size: 20))
                    .foregroundStyle(selectedTab == tab ? .orange : .white)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(selectedTab == tab ? .orange : .white)
            }
            .padding()
        }
    }
    private var tabIcon: String {
        switch tab {
        case .category: return "arrow.right.arrow.left"
        case .home: return "house.fill"
        case .profile: return "person.fill"
        case .favorite: return "heart"
        }
    }
    private var title: String {
        switch tab {
        case .category: return "Category"
        case .home: return "Home"
        case .profile: return "Profile"
        case .favorite: return "Favorite"
        }
    }
}
