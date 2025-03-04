//
//  ProductHomeView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import SwiftUI

struct TabViewNavigator: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        TabView {
            ProductHomeView()
                .tabItem {
                    Label("home", systemImage: "house.fill")
                }
            ProfileView()
                .tabItem {
                    Label("profile", systemImage: "person.fill")
                }
            CategoryView()
                .environmentObject(CategoryViewModel())
                .tabItem {
                    Label("category", systemImage: "arrow.right.arrow.left")
                }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
struct ProfileView: View {
    var body: some View {
        Text("Profile Screen")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Screen")
    }
}
#Preview {
    TabViewNavigator()
}
