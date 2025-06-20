//
//  AppDelegate.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/21/25.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseMessaging
import UserNotifications
 
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                     launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        return true
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .list, .sound])
    }
}
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?) {
        print("received fcm token: \(fcmToken ?? "No Token received")")
    }
}
