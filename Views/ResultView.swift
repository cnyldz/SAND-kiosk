//
//  ResultView.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import Foundation
import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: DreamSessionViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [AppColors.gradientOne, AppColors.gradientTwo]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                if let image = viewModel.session.generatedImage {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300, maxHeight: 400)
                            .cornerRadius(10)
                            .shadow(radius: 10)

                        // Polaroid-style overlay (visual only)
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.white.opacity(0.8))
                                .frame(height: 40)
                                .overlay(
                                    Text("RÜYA KARTI")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                )
                        }
                        .frame(maxWidth: 300, maxHeight: 400)
                    }
                }

                if let rarity = viewModel.session.rarityScore,
                   let absurdity = viewModel.session.absurdityScore {
                    Text("Tuhaflık: \(absurdity)   Benzersizlik: \(rarity)")
                        .foregroundColor(.white)
                        .font(.headline)

                    if rarity > 90 {
                        Text("Rüyanız en tuhaf %5 arasında yer alıyor!")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }

                HStack(spacing: 20) {
                    Button(action: {
                        if let image = viewModel.session.generatedImage {
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        }
                    }) {
                        Text("Rüyayı Yazdır")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#bf5c8e"))
                            .cornerRadius(10)
                    }

                    Button(action: {
                        viewModel.resetSession()
                    }) {
                        Text("Yeni Rüya Başlat")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}
