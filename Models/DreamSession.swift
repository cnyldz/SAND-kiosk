//
//  DreamSession.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import Foundation
import SwiftUI

struct DreamSession: Identifiable {
    let id = UUID()
    
    var dreamText: String = ""
    var name: String = ""
    var surname: String = ""
    var email: String = ""
    
    var rarityScore: Int? = nil
    var absurdityScore: Int? = nil
    
    var generatedImage: UIImage? = nil
    var generatedImageURL: URL? = nil
    
    var timestamp: Date = Date()
}
