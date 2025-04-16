import Foundation
import SwiftUI

enum ScreenState {
    case idle
    case dreamInput
    case userInfo
    case processing
    case result
}

@MainActor
class DreamSessionViewModel: ObservableObject {
    @Published var currentScreen: ScreenState = .idle
    @Published var name = ""
    @Published var surname = ""
    @Published var email = ""
    @Published var dreamText = ""
    @Published var uniquenessScore: Int?
    @Published var absurdityScore: Int?
    @Published var translatedDream: String?
    @Published var imageUrl: String?
    @Published var isProcessing = false
    @Published var error: String?
    
    func resetSession() {
        name = ""
        surname = ""
        email = ""
        dreamText = ""
        uniquenessScore = nil
        absurdityScore = nil
        translatedDream = nil
        imageUrl = nil
        error = nil
        currentScreen = .idle
        isProcessing = false
    }
    
    func updateUserInfo(name: String, surname: String, email: String) {
        self.name = name
        self.surname = surname
        self.email = email
    }
    
    func updateDreamText(_ text: String) {
        self.dreamText = text
    }
    
    func submitDream() {
        guard !dreamText.isEmpty else {
            error = "Please enter your dream"
            print("Validation failed: Dream text is empty")
            return
        }
        
        guard !name.isEmpty else {
            error = "Please enter your name"
            print("Validation failed: Name is empty")
            return
        }
        
        isProcessing = true
        error = nil
        currentScreen = .processing
        print("Starting dream analysis request - Name: \(name), Dream length: \(dreamText.count) characters")
        
        Task {
            do {
                print("Sending request to backend...")
                let response = try await BackendAPI.shared.analyzeDream(
                    name: name,
                    surname: surname,
                    email: email,
                    dreamText: dreamText
                )
                
                print("Received successful response - Uniqueness: \(response.uniquenessScore), Absurdity: \(response.absurdityScore)")
                self.uniquenessScore = response.uniquenessScore
                self.absurdityScore = response.absurdityScore
                self.translatedDream = response.translatedDream
                self.imageUrl = response.imageUrl
                self.currentScreen = .result
                self.isProcessing = false
            } catch {
                print("Dream analysis failed with error: \(error)")
                if let apiError = error as? APIError {
                    print("API Error details: \(apiError.errorDescription ?? "No description")")
                }
                self.error = "Failed to analyze dream: \(error.localizedDescription)"
                self.isProcessing = false
            }
        }
    }
}
