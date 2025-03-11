//
//  ProductViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/27/25.
//

import Foundation
final class ProductViewModel: ObservableObject {
    private var products: [Product] = []
    @Published var viewState: ViewState<[Product]> = .none
    private let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    @MainActor
    func loadProducts() async {
        viewState = .loading
        do {
            products = try await networkManager.loadData(url: EndPoint.endpoint)
            viewState = .loaded(products)
        } catch let error {
            viewState = .error(error.localizedDescription)
        }
    }
}
