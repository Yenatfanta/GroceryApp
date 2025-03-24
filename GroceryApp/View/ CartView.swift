//
//   CartView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/11/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var appTheme: AppTheme
    var body: some View {
        ZStack {
            appTheme.backgroundColor.ignoresSafeArea()
            Text("Here are your cart!")
        }
    }
}

#Preview {
    CartView()
}
