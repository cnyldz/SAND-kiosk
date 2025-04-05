import SwiftUI

struct DreamInputView: View {
    @ObservedObject var viewModel: DreamSessionViewModel
    
    // Animation states
    @State private var isLoaded = false

    var body: some View {
        ZStack {
            // Background
            Color(hex: "#06071d")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // User info section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Kişisel Bilgiler")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.bottom, 4)
                        
                        VStack(spacing: 16) {
                            customTextField(text: $viewModel.name, placeholder: "Adınız (zorunlu)", systemImage: "person")
                            customTextField(text: $viewModel.surname, placeholder: "Soyadınız (isteğe bağlı)", systemImage: "person.text.rectangle")
                            customTextField(text: Binding(
                                get: { viewModel.email.lowercased() },
                                set: { viewModel.email = $0.lowercased() }
                            ), placeholder: "E-posta (isteğe bağlı)", systemImage: "envelope")
                                .keyboardType(.emailAddress)
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(hex: "#0e1036"))
                    )
                    .padding(.horizontal)
                    
                    // Dream text input
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Rüyanız")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.bottom, 4)
                        
                        TextEditor(text: $viewModel.dreamText)
                            .frame(minHeight: 150)
                            .padding()
                            .foregroundColor(.white)
                            .textEditorBackground(Color(hex: "#0e1036"))
                            .cornerRadius(12)
                            .removeWhiteBackground()
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
                            .placeholder(when: viewModel.dreamText.isEmpty) {
                                Text("Rüyanızı buraya yazın... En detaylı şekilde anlatın...")
                                    .foregroundColor(Color.white.opacity(0.3))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 24)
                            }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(hex: "#0e1036"))
                    )
                    .padding(.horizontal)

                    // Submit button
                    Button(action: {
                        viewModel.submitDream()
                    }) {
                        HStack {
                            if viewModel.isProcessing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .padding(.trailing, 10)
                            } else {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 16))
                            }
                            
                            Text(viewModel.isProcessing ? "Gönderiliyor..." : "Rüyamı Gönder")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(hex: "#4c5f89"))
                        .cornerRadius(12)
                        .opacity(viewModel.name.isEmpty || viewModel.dreamText.isEmpty ? 0.5 : 1.0)
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.dreamText.isEmpty || viewModel.isProcessing)
                    .padding(.horizontal)
                    
                    if let error = viewModel.error {
                        Text(error)
                            .font(.system(size: 14))
                            .foregroundColor(AppColors.error)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(AppColors.error.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical, 24)
            }
            .removeWhiteBackground()
            .scrollDismissesKeyboard(.interactively)
        }
    }
    
    private func customTextField(text: Binding<String>, placeholder: String, systemImage: String) -> some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(Color.white.opacity(0.3))
                .frame(width: 24)
            
            TextField(placeholder, text: text)
                .foregroundColor(.white)
                .accentColor(.white)
                .placeholder(when: text.wrappedValue.isEmpty) {
                    Text(placeholder)
                        .foregroundColor(Color.white.opacity(0.3))
                }
            
            if !text.wrappedValue.isEmpty {
                Button(action: { text.wrappedValue = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.white.opacity(0.3))
                }
            }
        }
        .padding()
        .background(Color(hex: "#0e1036"))
        .cornerRadius(12)
    }
}
