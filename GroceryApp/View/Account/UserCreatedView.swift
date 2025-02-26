//
//  UserCreatedView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/26/25.
//

import SwiftUI
struct UserCreatedView: View {
    @Binding var userCreatedSuccessfully: Bool
    @Binding var user: User?
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        userCreatedSuccessfully = false
                    }
                }
            VStack(spacing: 24) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                Text("🎉 Account Created! 🎉")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                Text("\(user?.firstName ?? "") \(user?.lastName ?? "")")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                Text("Your account has been created successfully. You can now sign in to access all features.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Button {
                    withAnimation {
                        userCreatedSuccessfully = false
                        coordinator.navigate(to: Destination.loginPage)
                    }
                } label: {
                    Text("Sign In")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.orange)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.1), radius: 4)
                }
                .padding(.top, 8)
            }
            .padding(32)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.2), radius: 10)
            )
            .padding(.horizontal, 40)
        }
    }
}
