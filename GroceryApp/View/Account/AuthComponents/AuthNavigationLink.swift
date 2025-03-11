//
//  AuthNavigationLink.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/7/25.
//

import SwiftUI

struct AuthNavigationLink: View {
    let question: String
    let linkText: String
    let action: () -> Void
    var body: some View {
        HStack {
            Text(question)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button {
                action()
            } label: {
                Text(linkText)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.orange)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
    }
}
