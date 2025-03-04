//
//  ConfettiViewWrapper.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import Foundation
import SwiftUI
import UIKit

struct ConfettiViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) ->  ConfettiViewController {
        return ConfettiViewController()
    }
    func updateUIViewController(_ uiViewController: ConfettiViewController, context: Context) {}
}
