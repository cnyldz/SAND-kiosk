import SwiftUI

struct IdleView: View {
    @ObservedObject var viewModel: DreamSessionViewModel

    var body: some View {
        ZStack {
            // Dreamlike background
            LinearGradient(
                gradient: Gradient(colors: [AppColors.gradientOne, AppColors.gradientTwo]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Rüya yolculuğunuz başlasın")
                    .font(.custom("Lora-Bold", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                LottieView(filename: "test.json", loopMode: .loop, speed: 0.2)
                    .frame(width: 200, height: 200)
              
                Text("Dokunarak başlayın")
                    .font(.custom("Comfortaa-Bold", size: 24))
                    .foregroundColor(AppColors.sandSecondary)
            }
        }
        .onTapGesture {
            viewModel.currentScreen = .dreamInput
        }
    }
}
