//
//  AuthErrorMessage.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/7/25.
//

import SwiftUI

struct AuthErrorMessage: View {
    let message: String
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle")
                .foregroundStyle(.red)
            Text(message)
                .foregroundStyle(.red)
                .font(.callout)
        }
        .padding(.vertical, 4)
    }
}
