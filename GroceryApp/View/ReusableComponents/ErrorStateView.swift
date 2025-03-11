//
//  ErrorStateView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI

struct ErrorStateView: View {
    let message: String
    let retryAction: () -> Void
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundStyle(.orange)
            Text(message)
                .font(.title2)
                .fontWeight(.bold)
            Button {
                retryAction()
            } label: {
                Text("Try Again")
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
