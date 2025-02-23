//
//  LoginView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/23/25.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isSecure = true
    var body: some View {
        ZStack {
            backgroundLayer
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    formSection
                    signInButton
                }
                .padding()
                .frame(
                    maxWidth: UIScreen.main.bounds.width * 1,
                    alignment: .bottom
                )
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(radius: 10)
                )
            }
        }
    }
    private var headerSection: some View {
        Text("Sign in")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.black)
            .padding(.bottom, 10)
    }
    private var backgroundLayer: some View {
        Image("oranges")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    private var signInButton: some View {
        Button {
            
        } label: {
            Text("SIGN IN")
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.orange)
                .cornerRadius(25)
                .shadow(radius: 5)
        }
    }
    private var formSection: some View {
        VStack(spacing: 16) {
            CustomTextField(
                placeHolder: "Email",
                text: $email
            )
            CustomSecureField(
                placeHolder: "Password",
                text: $password,
                isSecured: $isSecure
            )
            Button {
             
            } label: {
               Text("Forgot Password?")
                    .font(.footnote)
                    .foregroundStyle(.orange)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

#Preview {
    LoginView()
}
