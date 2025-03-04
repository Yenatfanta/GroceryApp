//
//  CustomTextField.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/23/25.
//

import SwiftUI
struct CustomTextField: View {
    let placeHolder: String
    @Binding var text: String
    var body: some View {
        HStack {
            TextField(placeHolder, text: $text)
                .textContentType(.emailAddress)
                .textFieldStyle(CustomTextFieldStyle())
        }
        .padding()
        .cornerRadius(10)
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
