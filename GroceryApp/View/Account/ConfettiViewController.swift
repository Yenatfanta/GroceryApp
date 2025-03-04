//
//  ConfettiAnimationViewController.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import UIKit

class ConfettiViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        showConfetti()
    }
    func showConfetti() {
        let confettiLayer = CAEmitterLayer()
        confettiLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: 100)
        confettiLayer.emitterShape = .line
        confettiLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
        let colors: [UIColor] = [.red, .blue, .purple, .green, .orange, .yellow]
        let confettiTypes: [Shape] = [.circle, .square]
        var cells: [CAEmitterCell] = []
        for color in colors {
            for type in confettiTypes {
                let cell = CAEmitterCell()
                cell.lifetime = 6.0
                cell.birthRate = 10
                cell.velocity = CGFloat.random(in: 100...200)
                cell.emissionLongitude = .pi
                cell.emissionRange = .pi/4
                cell.spin = CGFloat.random(in: 2...5)
                cell.scale = 0.2
                cell.contents = confettiImage(type, color)?.cgImage
                cells.append(cell)
            }
        }
        confettiLayer.emitterCells = cells
        view.layer.addSublayer(confettiLayer)
    }
    func confettiImage(_ shape: Shape, _ color: UIColor) -> UIImage? {
        let size = CGSize(width: 10, height: 10)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        switch shape {
        case .circle:
            context?.fillEllipse(in: CGRect(origin: .zero, size: size))
        case .square:
            context?.fill(CGRect(origin: .zero, size: size))
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    enum Shape {
        case circle, square
    }
}
