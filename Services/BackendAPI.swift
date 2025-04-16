//
//  BackendAPI.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import Foundation

struct DreamAnalysisResponse: Codable {
    let uniquenessScore: Int
    let absurdityScore: Int
    let translatedDream: String?
    
    enum CodingKeys: String, CodingKey {
        case uniquenessScore = "uniqueness_score"
        case absurdityScore = "absurdity_score"
        case translatedDream = "translated_dream"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Convert decimal scores to integers (0-100)
        let rawUniqueness = try container.decode(Double.self, forKey: .uniquenessScore)
        let rawAbsurdity = try container.decode(Double.self, forKey: .absurdityScore)
        
        uniquenessScore = Int(rawUniqueness)
        absurdityScore = Int(rawAbsurdity * 100)
        translatedDream = try container.decodeIfPresent(String.self, forKey: .translatedDream)
    }
}

struct DreamAnalysisRequest: Codable {
    let name: String
    let surname: String
    let email: String
    let dream: String
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Invalid URL configuration"
            case .invalidResponse:
                return "Invalid response from server"
            case .networkError(let error):
                return "Network error: \(error.localizedDescription)"
            case .decodingError(let error):
                return "Failed to process response: \(error.localizedDescription)"
        }
    }
}

class BackendAPI {
    static let shared = BackendAPI()
    let baseURL = URL(string: "http://localhost:8001")!
    
    func analyzeDream(name: String, surname: String, email: String, dreamText: String) async throws -> DreamAnalysisResponse {
        let endpoint = baseURL.appendingPathComponent("analyze-dream")
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = DreamAnalysisRequest(
            name: name,
            surname: surname,
            email: email,
            dream: dreamText
        )
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(payload)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let responseString = String(data: data, encoding: .utf8) ?? "No error details"
                print("Server error response: \(responseString)")
                throw APIError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode(DreamAnalysisResponse.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
}
