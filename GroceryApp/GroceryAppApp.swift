//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/21/25.
//

import SwiftUI

@main
struct GroceryAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
                WelcomeView()
                .environmentObject(Coordinator())
                .environmentObject(UserViewModel())
                .environmentObject(AppTheme())
        }
    }
}
class AppTheme: ObservableObject {
    @Published var backgroundColor: Color = Color.orange.opacity(0.1)
}
