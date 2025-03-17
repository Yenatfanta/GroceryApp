//
//  VideoPlayerViewModel.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/17/25.
//

import Foundation
final class VideoPlayerViewModel: ObservableObject {
    @Published var videoURL: URL?
    func playVideo(videoURL: String) {
        guard let url = URL(string: videoURL) else {
            print("invalid video url")
            return
        }
        self.videoURL = url
    }
}
