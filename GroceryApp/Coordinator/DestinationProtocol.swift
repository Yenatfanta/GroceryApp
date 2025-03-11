//
//  Destination.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/22/25.
//

import Foundation
import SwiftUI
protocol DestinationProtocol: Hashable {
    func makeView() -> AnyView
}
enum Destination: Hashable, DestinationProtocol {
    case welcomePage
    case joinPage
    case createAccount
    case loginPage
    case productTab
    case detailView(String)
    case recipeDetailView(String)
    case favorite
    func makeView() -> AnyView {
        switch self {
        case .welcomePage:
            return AnyView(WelcomeView())
        case .joinPage:
            return AnyView(JoinFreshView())
        case .createAccount:
            return AnyView(CreateAccountView())
        case .loginPage:
            return AnyView(LoginView())
        case .productTab:
            return AnyView(CustomTabBarView())
        case .detailView(let selectedMeal):
            return AnyView(CategoryDetailView(selectedMeal: selectedMeal))
        case .recipeDetailView(let mealId):
            return AnyView(RecipeDetailView(mealId: mealId))
        case .favorite:
            return AnyView(FavoritesView())
        }
    }
}
