//
//  JoinFreshView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/21/25.
//

import SwiftUI
struct JoinFreshView: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        VStack {
            Image("motor")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            VStack(spacing: 5) {
                Text("Fast and Responsible Delivery by Our courier")
                    .font(.title)
                    .bold()
                    .padding()
                Text(String(repeating: "Lorem ipsum dolor sit amet. ", count: 5))
                    .font(.body)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            HStack(spacing: 8) {
                Circle().fill(Color.green).frame(width: 8, height: 8)
                Circle().fill(Color.green).frame(width: 8, height: 8)
            }
            .padding(.top, 10)
            Spacer()
            VStack {
                Button {
                    coordinator.navigate(to: Destination.createAccount)
                }
                label: {
                    Text("Create An Account")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.black)
                        .cornerRadius(25)
                        .padding(.horizontal, 40)
                        .shadow(radius: 5)
                }
                Button {
                    // TODO: navigate to login page
                }
                label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .padding(.horizontal, 40)
                        .shadow(radius: 5)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .padding(.bottom, 40)

    }
}

#Preview {
    JoinFreshView()
        .environmentObject(Coordinator())
}
