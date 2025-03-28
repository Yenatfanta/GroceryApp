//
//  AppDelegate.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/21/25.
//

import Foundation
import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                     launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
