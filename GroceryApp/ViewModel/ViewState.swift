//
//  ViewState.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/3/25.
//

import Foundation
enum ViewState<T> {
    case none
    case loading
    case loaded(T)
    case error (String)
}
