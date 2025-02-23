//
//  Destination.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/22/25.
//

import Foundation
import SwiftUI
protocol DestinationProtocol: Hashable {
    func makeView() ->  AnyView
}
struct Destination: DestinationProtocol {
    private let id: String
    private let viewBuilder: () -> AnyView
    func makeView() -> AnyView {
        viewBuilder()
    }
    static let welcomePage = Destination(id: "welcome") {
        AnyView(WelcomeView())
    }
    static let joinPage = Destination(id: "join") {
        AnyView(JoinFreshView())
    }
    static let createAccount = Destination(id: "create") {
        AnyView(CreateAccountView())
    }
    static func ==(lhs: Destination, rhs: Destination) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
/*
 enum ViewDestination {
     case welcomePage, joinPage, getStartedPage, accountCreated, signInPage, homePage,
      categoriesPage, productDetail, cartPage, checkOuPage, paymentPage, orderProgress, orderTracking, reviewPage
 }
 */
