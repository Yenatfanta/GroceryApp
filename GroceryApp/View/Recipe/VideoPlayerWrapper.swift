//
//  VideoPlayerWrapper.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/17/25.
//

import Foundation
import SwiftUI
import UIKit
import WebKit
import SafariServices

struct VideoPlayerWrapper: UIViewControllerRepresentable {
    let videoURL: URL
    @Environment(\.presentationMode) var presentationMode
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let sfViewController = SFSafariViewController(url: videoURL)
        sfViewController.delegate = context.coordinator
        return sfViewController
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, SFSafariViewControllerDelegate {
            let parent: VideoPlayerWrapper
            init(_ parent: VideoPlayerWrapper) {
                self.parent = parent
            }
            func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
}
