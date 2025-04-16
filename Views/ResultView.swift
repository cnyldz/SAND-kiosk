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
                if let imageUrlString = viewModel.imageUrl,
                   let url = URL(string: imageUrlString) {
                    // Polaroid frame: white border with thicker bottom for caption
                    VStack(spacing: 0) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable()
                                     .scaledToFit()
                                     .frame(maxWidth: 300)
                            case .failure(_):
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                                    .foregroundColor(.gray)
                            default:
                                ProgressView()
                            }
                        }
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 40)
                            .overlay(
                                Text("RÜYA KARTI")
                                    .font(.caption)
                                    .foregroundColor(.black)
                            )
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
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
                        if let imageUrlString = viewModel.imageUrl,
                           let url = URL(string: imageUrlString) {
                            // TODO: Download image from URL and save to photos
                        }
                    }) {
                        Text("Rüyayı Yazdır")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#bf5c8e"))
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.imageUrl == nil)

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
