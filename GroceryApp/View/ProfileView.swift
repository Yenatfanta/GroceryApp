//
//  ProfileView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/6/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appTheme: AppTheme
    var body: some View {
        ZStack {
//            appTheme.backgroundColor.ignoresSafeArea()
            Text("Profile view")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(appTheme.backgroundColor)
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppTheme())
}
