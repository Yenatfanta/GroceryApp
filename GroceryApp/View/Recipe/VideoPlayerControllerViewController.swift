//
//  VideoPlayerControllerViewController.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/17/25.
//

import UIKit
import AVFoundation
import AVKit

//class VideoPlayerControllerViewController: UIViewController {
//    private var player: AVPlayer?
//    private var playerLayer: AVPlayerLayer?
//    let viewModel = VideoPlayerViewModel()
//    var videoURL: URL?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        playVideo()
//    }
//    func setVideoURL(url: URL) {
//        self.videoURL = url
//    }
////    func playVideo() {
////        if let url = videoURL {
////            player = AVPlayer(url: url)
////            playerLayer = AVPlayerLayer(player: player)
////            playerLayer?.frame = view.bounds
////            playerLayer?.videoGravity = .resizeAspect
////            if let playerLayer = playerLayer {
////                view.layer.addSublayer(playerLayer)
////            }
////            player?.play()
////        }
////    }
//    func playVideo() {
//           guard let url = videoURL else { return } // ✅ Use videoURL instead of viewModel.videoURL
//
//           player = AVPlayer(url: url)
//           playerLayer = AVPlayerLayer(player: player)
//           playerLayer?.frame = view.bounds
//           playerLayer?.videoGravity = .resizeAspectFill
//           
//           if let playerLayer = playerLayer {
//               view.layer.addSublayer(playerLayer)
//           }
//
//           player?.play() // ✅ Start playing immediately
//       }
//}
