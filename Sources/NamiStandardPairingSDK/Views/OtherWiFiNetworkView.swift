// Copyright (c) nami.ai

import Tomonari
import SwiftUI

// MARK: - OtherWiFiNetworkView

struct OtherWiFiNetworkView: View {
    // MARK: Lifecycle

    init(viewModel: OtherWiFiNetwork.ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: OtherWiFiNetwork.ViewModel

    var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                NamiChatBubble(I18n.Pairing.OtherWiFiNetwork.header.localized)
                    .padding()
                Spacer()
                NamiTextField(placeholder: I18n.Pairing.OtherWiFiNetwork.namePlaceholder.localized, text: Binding(get: {
                    viewModel.state[keyPath: \.networkName]
                }, set: { value in
                    viewModel.state[keyPath: \.networkName] = value
                }), returnKeyType: .done)
                    .padding()
                Button(I18n.General.ok.localized, action: { viewModel.send(event: .didConfirmName) })
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
                    .disabled(viewModel.state.networkName.isEmpty)
                Button(I18n.Pairing.OtherWiFiNetwork.backButton.localized, action: { viewModel.send(event: .goBack) })
                    .buttonStyle(NamiActionButtonStyle(rank: .secondary))
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
