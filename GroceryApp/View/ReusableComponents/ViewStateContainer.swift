//
//  ViewStateContainer.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI

struct ViewStateContainer<ViewData, Content: View, LoadingView: View, ErrorView: View>: View {
    let viewState: ViewState<ViewData>
    let content: (ViewData) -> Content
    let loadingView: LoadingView
    let errorView: ErrorView
    init(viewState: ViewState<ViewData>,
         @ViewBuilder content: @escaping (ViewData) -> Content,
         @ViewBuilder loadingView: () -> LoadingView = {ProgressView()},
         @ViewBuilder errorView: @escaping () -> ErrorView = {Text("Something Went wrong")}) {
        self.viewState = viewState
        self.content = content
        self.loadingView = loadingView()
        self.errorView = errorView()
    }
    var body: some View {
        switch viewState {
        case .none:
            loadingView
        case .loading:
            loadingView
        case .loaded(let data):
            content(data)
        case .error(_):
            errorView
        }
    }
}
