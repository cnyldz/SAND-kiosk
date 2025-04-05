//
//  ProcessingView.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import SwiftUI

struct ProcessingView: View {
    @ObservedObject var viewModel: DreamSessionViewModel
    @State private var animationPhase = 0
    
    let animationTexts = [
        "Rüyanız analiz ediliyor...",
        "Benzersizlik ölçülüyor...",
        "Görsel oluşturuluyor...",
        "Sonuçlar hazırlanıyor..."
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [AppColors.gradientOne, AppColors.gradientTwo]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text(animationTexts[animationPhase])
                    .font(.title2)
                    .foregroundColor(.white)
                    .transition(.opacity)
                    .id("phase\(animationPhase)")  // Force view refresh on text change

                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
        }
        .onAppear {
            startPhaseAnimation()
        }
    }
    
    private func startPhaseAnimation() {
        // Cycle through animation phases every 1.5 seconds
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            withAnimation {
                animationPhase = (animationPhase + 1) % animationTexts.count
            }
        }
    }
}
