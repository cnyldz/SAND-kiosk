//
//  View+Modifiers.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import Foundation
import SwiftUI

extension View {
    func textEditorBackground(_ color: Color) -> some View {
        self.onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear {
            UITextView.appearance().backgroundColor = nil
        }
        .background(color)
    }
    
    func removeWhiteBackground() -> some View {
        self.background(Color.clear)
            .scrollContentBackground(.hidden)
    }
}

// Add placeholder functionality to TextEditor
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .topLeading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
