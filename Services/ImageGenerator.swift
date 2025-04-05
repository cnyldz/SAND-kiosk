import Foundation

class ImageGenerator {
    static let shared = ImageGenerator()
    private let apiKey = ProcessInfo.processInfo.environment["FAL_KEY"] ?? ""
    private let endpoint = "https://api.fal.ai/v1/models/fal-ai/recraft-v3"
    
    func generateImage(prompt: String) async throws -> URL? {
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: Any] = [
            "arguments": [
                "prompt": prompt,
                "image_size": "portrait_4_3",
                "style": "digital_illustration/modern_folk"
            ],
            "with_logs": true
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "ImageGenerator", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NSError(domain: "ImageGenerator", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "API error: \(httpResponse.statusCode)"])
        }
        
        let response = try JSONDecoder().decode(RecraftResponse.self, from: data)
        return URL(string: response.images.first?.url ?? "")
    }
}

struct RecraftResponse: Codable {
    struct Image: Codable {
        let url: String
    }
    let images: [Image]
} 