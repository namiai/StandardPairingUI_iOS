// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - BluetoothUsageHintView

struct BluetoothUsageHintView: View {
    // MARK: Lifecycle

    init(viewModel: BluetoothUsageHint.ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: BluetoothUsageHint.ViewModel

    var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                NamiChatBubble(I18n.Pairing.BluetoothUsageHint.header.localized)
                    .padding(.horizontal)
                Spacer()
                Button(I18n.Pairing.BluetoothUsageHint.confirm.localized, action: { viewModel.send(event: .tapNext) })
                    .disabled(viewModel.state.nextTapped)
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}