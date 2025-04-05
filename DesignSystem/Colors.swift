//
//  Colors.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import SwiftUI

struct AppColors {
    static let sandPrimary = Color(hex: "#faefdb")
    static let sandSecondary = Color(hex: "#efe1cb")
    static let sandTertiary = Color(hex: "#4c5f89")
    static let sandBackground = Color(hex: "#06071d")
    static let gold = Color(hex: "#FFD700")
    static let surface = Color(hex: "#0e1036")
    static let error = Color(hex: "#FF3B30")
    static let danger = Color(hex: "#FF3B30")
    static let text = Color(hex: "#efe1cb")
    static let green = Color(hex: "#00b894")
    static let onPrimary = Color(hex: "#FFFFFF")
    static let onAccent = Color(hex: "#FFFFFF")
    static let onBackground = Color(hex: "#000000")
    static let onSurface = Color(hex: "#000000")
    static let onError = Color(hex: "#FFFFFF")
    static let success = Color(hex: "#30D158")
    static let warning = Color(hex: "#FFA500")
    static let info = Color(hex: "#5AC8FA")
    static let notification = Color(hex: "#FFCC00")
    static let disabled = Color(hex: "#A0A0A0")
    static let placeholder = Color(hex: "#4c5f89")
    static let backdrop = Color(hex: "#FFFFFF")
    static let buttonBG1 = Color(hex: "#FE722D")
    static let buttonBG2 = Color(hex: "#000000")
    static let gradientOne = Color(hex: "#06071d")
    static let gradientTwo = Color(hex: "#4c5f89")
    static let gradientThree = Color(hex: "#06071d")
    static let secondaryText = Color(hex: "#fff")
    static let textSecondary = Color(hex: "#efe1cb")
    static let textTertiary = Color(hex: "#999999")
    static let textDark = Color(hex: "#06071d")
    static let textLight = Color(hex: "#efe1cb")
    static let grey = Color(hex: "#8E8E93")
    static let lightGray = Color(hex: "#E5E5EA")
    static let yellow = Color(hex: "#FFCC00")
    static let light = Color(hex: "#FFFFFF")
    static let dark = Color(hex: "#000000")
    static let white = Color(hex: "#FFFFFF")
    static let messageBackground = Color(hex: "#F4F4F4")
    static let chatIconDefault = Color(hex: "#9E9E9E")
    static let chatAvatarBackground = Color(hex: "#f0f0f0")
    static let chatMessageBubbleLight = Color(hex: "#F0F0F0")
    static let chatMessageBubbleDark = Color(hex: "#1a1a1a")
    static let chatMessageText = Color(hex: "#000000")
    static let chatMessageTime = Color(hex: "#666666")
    static let chatStatusConnected = Color(hex: "#4CAF50")
    static let chatStatusDisconnected = Color(hex: "#FF5252")
    static let chatBorder = Color(hex: "#E0E0E0")
    static let chatSecondaryText = Color(hex: "#999999")
    static let chatDateBackground = Color(hex: "#f0f0f0")
    static let cardSurface = Color(hex: "#FFFFFF")
    static let cardShadow = Color(hex: "#000000")
    static let cardOverlay = Color(hex: "#D72A2A")
    static let userAvatarBackground = Color(hex: "#F5F5F5")
    static let cardElevated = Color(hex: "#FFFFFF")
    static let shareButtonBackground = Color(hex: "#FE722D")
    static let onlineIndicator = Color(hex: "#4CAF50")
    static let onlineIndicatorBorder = Color(hex: "#FFFFFF")
    static let chatItemBackground = Color(hex: "#0e1036")
    static let dreamCardBackground = Color(hex: "#0e1036")
    static let dreamInputBackground = Color(hex: "#06071d")
    static let submitButtonBackground = Color(hex: "#4c5f89")
    static let notificationBackground = Color(hex: "#06071d")
    static let modalOverlayBackground = Color(hex: "#06071d")
    static let border = Color(hex: "#E1E1E1")
    static let black = Color(hex: "#000000")
    static let cardBackground = Color(hex: "#FFFFFF")
    static let shadowColor = Color(hex: "#000000")
    static let test = Color(hex: "#FF00FF")
    static let modalBackground = Color(hex: "#06071d")
    static let modalSurface = Color(hex: "#0e1036")
    static let modalText = Color(hex: "#efe1cb")
    static let modalButtonText = Color(hex: "#efe1cb")
    static let modalDangerButton = Color(hex: "#FF3B30")
    static let modalCancelButton = Color(hex: "#4c5f89")
    static let modalOverlay = Color(hex: "#000000") 
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}
