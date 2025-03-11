//
//  AuthButton.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/7/25.
//

import SwiftUI

struct AuthButton: View {
    let title: String
    let action: () -> Void
    let isLoading: Bool
    var body: some View {
        Button {
            action()
        } label: {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .frame(maxWidth: .infinity, minHeight: 56)
            } else {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, minHeight: 56)
            }
        }
        .background(Color.orange)
        .cornerRadius(28)
        .disabled(isLoading)
    }
}
