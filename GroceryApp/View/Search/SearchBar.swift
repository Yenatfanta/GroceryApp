//
//  SearchBar.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 6/19/25.
//

import SwiftUI

struct SearchBar: View {
    @State var searchManager: SearchManager = SearchManager()
    @FocusState private var isSearchFieldFocused: Bool
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField(
                    "Search for food, categories...",
                    text: $searchManager
                        .searchText)
                .focused($isSearchFieldFocused)
                .onChange(of: searchManager.searchText) { _, _ in
                   // searchManager.performSearch()
                }
                .onTapGesture {
                    searchManager.isSearching = true
                }
                if !searchManager.searchText.isEmpty {
                    Button {
                      //  searchManager.clearSearch()
                        isSearchFieldFocused = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            if searchManager.isSearching {
                Button {
                   // searchManager.clearSearch()
                    isSearchFieldFocused = false
                } label: {
                    Text("Cancel")
                }
                .foregroundStyle(.orange)
            }
        }
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.3), value: searchManager.isSearching)
    }
}

#Preview {
    SearchBar()
}
