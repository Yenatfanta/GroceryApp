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
    @State var isActive = false
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
                Text("\(user?.firstName ?? "unknown") \(user?.lastName ?? "unknown")")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                Text("Your account has been created successfully. You can now sign in to access all features.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)        
            }
            .padding(32)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.2), radius: 10)
            )
            .padding(.horizontal, 40)
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            if userCreatedSuccessfully {
                if isActive {
                    VStack {
                    }
                    .onAppear {
                        coordinator.navigate(to: Destination.productTab)
                    }
                } else {
                    ConfettiViewWrapper()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isActive = true
                            }
                        }
                }
            }
        }
    }
}
