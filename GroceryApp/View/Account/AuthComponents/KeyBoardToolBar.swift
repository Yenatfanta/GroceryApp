//
//  KeyBoardToolBar.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/7/25.
//

import Foundation
import SwiftUI
struct KeyBoardToolBar: ToolbarContent {
    let onDone: () -> Void
    var body: some ToolbarContent {
        ToolbarItem(placement: .keyboard) {
            HStack {
                Spacer()
                Button {
                    onDone()
                } label: {
                    Text("Done")
                }
            }
        }
    }
}
