//
//  AuthPasswordField.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/7/25.
//

import SwiftUI

struct AuthPasswordField<Field: Hashable>: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    @Binding var isVisible: Bool
    var submitLabel: SubmitLabel = .next
    var onSubmit: (() -> Void)?
    @FocusState.Binding var focusedState: Field
    let field: Field
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            ZStack(alignment: .trailing) {
                if isVisible {
                    TextField(placeholder, text: $text)
                        .textContentType(.oneTimeCode)
                        .textFieldStyle(CustomTextFieldStyle())
                        .focused($focusedState, equals: field)
                        .submitLabel(submitLabel)
                        .onSubmit {
                            onSubmit?()
                        }
                } else {
                    SecureField(placeholder, text: $text)
                        .textContentType(.oneTimeCode)
                        .textFieldStyle(CustomTextFieldStyle())
                        .focused($focusedState, equals: field)
                        .submitLabel(submitLabel)
                        .onSubmit {
                            onSubmit?()
                        }

                }
                Button {
                    isVisible.toggle()
                } label: {
                    Image(systemName: isVisible ? "eye.slash" : "eye")
                        .foregroundStyle(.gray)
                        .padding(.trailing, 12)
                }
            }
        }
    }
}
