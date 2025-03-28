//
//  UserInfoView.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import SwiftUI

struct UserInfoView: View {
    @ObservedObject var viewModel: DreamSessionViewModel
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [AppColors.gradientOne, AppColors.gradientTwo]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Bilgilerini gir")
                    .font(.title)
                    .foregroundColor(.white)

                Group {
                    TextField("Adınız (zorunlu)", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Soyadınız (isteğe bağlı)", text: $surname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("E-posta (isteğe bağlı)", text: $email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )

                Button(action: {
                    guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    viewModel.updateUserInfo(name: name, surname: surname, email: email)
                    viewModel.currentScreen = .processing
                }) {
                    Text("Devam Et")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#bf5c8e"))
                        .cornerRadius(10)
                }
                .padding(.top, 16)
            }
            .padding()
        }
    }
}
