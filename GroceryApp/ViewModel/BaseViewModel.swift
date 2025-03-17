//
//  BaseViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import Foundation
class BaseViewModel<T: Codable, U>: ObservableObject {
    // MARK: - View state
    @Published var viewState: ViewState<U> = .none
    // MARK: - Dependency injection
    private let networkManager: NetworkManagerProtocol
    // MARK: -  properties
    private let urlProvider: () -> String
    private let transform: (T) -> U
    private var testData: U?
    // MARK: - Initializer
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared,
         urlProvider: @escaping () -> String, transform: @escaping (T) -> U ) {
        self.networkManager = networkManager
        self.urlProvider = urlProvider
        self.transform = transform
    }
    deinit {
        
    }
}
// MARK: - Fetch Logic
extension BaseViewModel {
    @MainActor
    func fetchData() async {
        if let testData = testData {
            await MainActor.run {
                viewState = .loaded(testData)
            }
        } else {
            viewState = .loading
            do {
                let data: T = try await networkManager.loadData(url: urlProvider())
                viewState = .loaded(transform(data))
            } catch {
                viewState = .error(error.localizedDescription)
            }
        }
    }
}
