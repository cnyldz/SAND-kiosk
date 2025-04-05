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
    @State private var generatedImage: UIImage? = nil // Temporary state for the generated image

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [AppColors.gradientOne, AppColors.gradientTwo]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                if let image = generatedImage {
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

                if let uniqueness = viewModel.uniquenessScore,
                   let absurdity = viewModel.absurdityScore {
                    VStack(spacing: 16) {
                        Text("Rüya Analizi")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.bottom, 8)
                        
                        Text("Tuhaflık: %\(absurdity)")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Text("Benzersizlik: %\(uniqueness)")
                            .foregroundColor(.white)
                            .font(.headline)

                        if uniqueness > 90 {
                            Text("Rüyanız en tuhaf %5 arasında yer alıyor!")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        } else if uniqueness > 75 {
                            Text("Rüyanız oldukça benzersiz!")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        if let translatedDream = viewModel.translatedDream {
                            Text("İngilizce Çeviri:")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.top)
                            
                            Text(translatedDream)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(16)
                }

                HStack(spacing: 20) {
                    Button(action: {
                        if let image = generatedImage {
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
                    .disabled(generatedImage == nil)

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
            .onAppear {
                // Here we would generate the image based on the translated dream
                if let translatedDream = viewModel.translatedDream {
                    // TODO: Call image generation service
                    // For now, we'll use a placeholder image
                    generatedImage = UIImage(systemName: "photo")
                }
            }
        }
    }
}
