import Foundation
import SwiftUI

enum ScreenState {
    case idle
    case dreamInput
    case userInfo
    case processing
    case result
}

class DreamSessionViewModel: ObservableObject {
    @Published var currentScreen: ScreenState = .idle
    @Published var session = DreamSession()

    func resetSession() {
        session = DreamSession()
        currentScreen = .idle
    }

    func updateUserInfo(name: String, surname: String, email: String) {
        session.name = name
        session.surname = surname
        session.email = email
    }

    func updateDreamText(_ text: String) {
        session.dreamText = text
    }

    func updateScores(rarity: Int, absurdity: Int) {
        session.rarityScore = rarity
        session.absurdityScore = absurdity
    }

    func updateGeneratedImage(image: UIImage, url: URL?) {
        session.generatedImage = image
        session.generatedImageURL = url
    }
}
