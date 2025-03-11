//
//  CustomTextField.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/23/25.
//

import SwiftUI
struct CustomTextFieldStyle: TextFieldStyle {
    // swiftlint:disable:next identifier_name
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 12)
            .padding(.vertical, 14)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.orange.opacity(0.3), lineWidth: 1)
            )
    }
}
struct CustomSecureField: View {
    let placeHolder: String
    @Binding var text: String
    @Binding var isSecured: Bool
    var body: some View {
        ZStack {
            if isSecured {
                SecureField(placeHolder, text: $text)
                    .textContentType(.password)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeHolder, text: $text)
                    .textContentType(.password)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            Button {
                $isSecured.wrappedValue.toggle()
            } label: {
                Image(systemName: $isSecured.wrappedValue ? "eye.slash" : "eye")
                    .foregroundStyle(.gray)
            }
            .padding()
            .scaledToFit()
            .frame(height: 20)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .cornerRadius(5)
    }
}
