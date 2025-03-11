//
//  Coordinator.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/22/25.
//

import Foundation
import SwiftUI
protocol CoordinatorProtocol {
    func navigate(to destination: any DestinationProtocol)
}
final class Coordinator: ObservableObject, CoordinatorProtocol {
    @Published var navigationPath = NavigationPath()
    func navigate(to destination: any DestinationProtocol) {
        navigationPath.append(destination)
    }
    @ViewBuilder
    func build(_ destination: any DestinationProtocol) -> AnyView {
        destination.makeView()
    }
}
