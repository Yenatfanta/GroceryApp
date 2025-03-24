//
//  WelcomeView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/21/25.
//

import SwiftUI
struct WelcomeView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appTheme: AppTheme
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            ZStack {
                appTheme.backgroundColor.ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("first")
                        .resizable()
                        .scaledToFit()
                        .layoutPriority(1)
                    VStack(spacing: 5) {
                        Text("Welcome to Fresh Fruits")
                            .font(.title)
                            .bold()
                        Text("Grocery application")
                            .font(.headline)
                            .foregroundStyle(.gray)
                        Text(String(repeating: "Lorem ipsum dolor sit amet. ", count: 5))
                            .font(.body)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    HStack(spacing: 8) {
                        Circle().fill(Color.gray.opacity(0.5)).frame(width: 8, height: 8)
                        Circle().fill(Color.orange).frame(width: 8, height: 8) // Active dot
                        Circle().fill(Color.gray.opacity(0.5)).frame(width: 8, height: 8)
                    }
                    .padding(.top, 10)
                    Spacer()
                    Button {
                        coordinator.navigate(to: Destination.joinPage)
                    }
                    label: {
                        Text("Next")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.orange)
                            .cornerRadius(25)
                            .padding(.horizontal, 40)
                            .shadow(radius: 5)
                    }
                    .accessibilityIdentifier("Next")
                    .padding(.bottom, 10)
                }}
            .navigationDestination(for: Destination.self) { destination in
                coordinator.build(destination)
                    .environmentObject(coordinator)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(Coordinator())
}
