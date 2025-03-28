//
//  LottieView.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var filename: String
    let loopMode: LottieLoopMode
    let speed: CGFloat
    
    init(filename: String, loopMode: LottieLoopMode, speed: CGFloat = 1.0) {
        self.filename = filename
        self.loopMode = loopMode
        self.speed = speed
    }

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        animationView.play()
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // no-op
    }
}
