import SwiftUI

struct IdleView: View {
    @ObservedObject var viewModel: DreamSessionViewModel
    @State private var showContent = false

    var body: some View {
        ZStack {
            // Dreamlike background
            LinearGradient(
                gradient: Gradient(colors: [AppColors.gradientOne, AppColors.gradientTwo]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()
                Text("Rüya yolculuğunuz başlasın")
                    .font(.custom("Lora-Bold", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                    .animation(.easeOut(duration: 1).delay(0.2), value: showContent)
                LottieView(filename: "test.json", loopMode: .loop, speed: 0.2)
                    .frame(width: 250, height: 250)

                Button(action: { viewModel.currentScreen = .dreamInput }) {
                    Text("Dokunarak başlayın")
                        .font(.custom("Comfortaa-Bold", size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(AppColors.sandSecondary)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)

                Spacer()
            }
        }
        .onAppear {
            showContent = true
        }
    }
}
