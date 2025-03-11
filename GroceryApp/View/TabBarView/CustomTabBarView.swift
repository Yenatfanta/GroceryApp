//
//  CustomTabBarView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI

enum Tab {
    case home, category, favorite, profile
}
struct CustomTabBarView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var selectedTab: Tab = .home
    var body: some View {
        ZStack {
            VStack {
                switch selectedTab {
                case .home:
                    ProductHomeView()
                case .category:
                    CategoryView()
                case .favorite:
                    FavoritesView()
                        .environmentObject(coordinator)
                case .profile:
                    ProfileView()
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            VStack {
                Spacer()
                HStack {
                    TabBarButton(tab: .home, selectedTab: $selectedTab)
                    TabBarButton(tab: .category, selectedTab: $selectedTab)
                    TabBarButton(tab: .favorite, selectedTab: $selectedTab)
                    TabBarButton(tab: .profile, selectedTab: $selectedTab)
                }
                .frame(height: 60)
                .background(Color.brown.shadow(radius: 10))
                .cornerRadius(12)

            }
        }
    }
}

#Preview {
    CustomTabBarView()
}
