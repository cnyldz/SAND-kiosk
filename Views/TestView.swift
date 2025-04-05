import SwiftUI

// Create a mock image generator for testing
class MockImageGenerator {
    static let shared = MockImageGenerator()
    
    func generateImage(prompt: String) async throws -> URL? {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        // Use a placeholder image URL
        return URL(string: "https://picsum.photos/800/600")
    }
}

struct TestView: View {
    @State private var dreamText: String = ""
    @State private var generatedImage: UIImage?
    @State private var isLoading = false
    @State private var error: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Test Dream Image Generation")
                .font(.title)
            
            TextEditor(text: $dreamText)
                .frame(height: 100)
                .border(Color.gray)
                .padding()
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            if let image = generatedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
            
            Button(action: generateImage) {
                Text("Generate Image")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(dreamText.isEmpty || isLoading)
        }
        .padding()
    }
    
    private func generateImage() {
        isLoading = true
        error = nil
        
        Task {
            do {
                if let imageUrl = try await MockImageGenerator.shared.generateImage(prompt: dreamText) {
                    let (imageData, _) = try await URLSession.shared.data(from: imageUrl)
                    if let image = UIImage(data: imageData) {
                        await MainActor.run {
                            self.generatedImage = image
                        }
                    }
                }
            } catch {
                await MainActor.run {
                    self.error = error.localizedDescription
                }
            }
            
            await MainActor.run {
                isLoading = false
            }
        }
    }
}

#Preview {
    TestView()
} 