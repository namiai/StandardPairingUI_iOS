// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - PowerOnAndScanningView

struct PowerOnAndScanningView: View {
    // MARK: Lifecycle

    init(viewModel: PowerOnAndScanning.ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel

    var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                NamiChatBubble(I18n.Pairing.PowerOnAndScanning.header1.localized)
                    .padding()
                NamiChatBubble(I18n.Pairing.PowerOnAndScanning.header2.localized)
                    .padding()
                if viewModel.state.showsProgressIndicator {
                    ProgressView()
                        .padding()
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
