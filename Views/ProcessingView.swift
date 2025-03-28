//
//  ProcessingView.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import SwiftUI

struct ProcessingView: View {
    @ObservedObject var viewModel: DreamSessionViewModel
    @State private var isProcessing = true

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [AppColors.gradientOne, AppColors.gradientTwo]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Rüyanız analiz ediliyor...")
                    .font(.title2)
                    .foregroundColor(.white)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1), value: isProcessing)

                Text("Benzersizlik ve tuhaflık ölçülüyor...")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1).delay(0.5), value: isProcessing)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
        }
        .onAppear {
            simulateDreamAnalysis()
        }
    }

    private func simulateDreamAnalysis() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            viewModel.updateScores(rarity: Int.random(in: 70...100), absurdity: Int.random(in: 60...100))
            viewModel.updateGeneratedImage(image: UIImage(systemName: "photo")!, url: nil)
            viewModel.currentScreen = .result
        }
    }
}
