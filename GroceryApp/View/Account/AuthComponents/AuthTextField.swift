//
//  AuthTextField.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/7/25.
//

import SwiftUI

struct AuthTextField<Field: Hashable>: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var keyboardtype: UIKeyboardType = .default
    var submitLabel: SubmitLabel = .next
    var onSubmit: (() -> Void)?
    @FocusState.Binding var focusState: Field?
    let field: Field
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            TextField(placeholder, text: $text)
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(keyboardtype)
                .textInputAutocapitalization(
                    keyboardtype == .emailAddress ? .none : .words)
                .autocorrectionDisabled(keyboardtype == .emailAddress)
                .focused($focusState, equals: field)
                .submitLabel(submitLabel)
                .onSubmit {
                    onSubmit?()
                }
        }
    }
}
