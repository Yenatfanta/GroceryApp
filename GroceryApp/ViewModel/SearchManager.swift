//
//  SearchManager.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 6/19/25.
//

import Foundation

@Observable
final class SearchManager {
    var searchText = ""
    var isSearching = false
    var searchResults: [MealCategory] = []
   
}
