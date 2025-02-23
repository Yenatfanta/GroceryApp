//
//  SplashScreenView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 2/21/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive = false
    var body: some View {
        if isActive {
            WelcomeView()
                .environmentObject(Coordinator())
        } else {
            ZStack {
                Color.orange
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .layoutPriority(1)
                    Text("Fresh Fruits")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.top, 10)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
