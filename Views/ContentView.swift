//
//  ContentView.swift
//  SAND kiosk
//
//  Created by Heavyshark on 28.03.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = DreamSessionViewModel()

    var body: some View {
        ZStack {
            switch viewModel.currentScreen {
            case .idle:
                IdleView(viewModel: viewModel)
            case .dreamInput:
                DreamInputView(viewModel: viewModel)
            case .userInfo:
                UserInfoView(viewModel: viewModel)
            case .processing:
                ProcessingView(viewModel: viewModel)
            case .result:
                ResultView(viewModel: viewModel)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
