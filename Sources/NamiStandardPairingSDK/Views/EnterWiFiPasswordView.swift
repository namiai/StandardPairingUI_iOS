// Copyright (c) nami.ai

import Tomonari
import SwiftUI

// MARK: - EnterWiFiPasswordView

struct EnterWiFiPasswordView: View {
    // MARK: Lifecycle

    init(viewModel: EnterWiFiPassword.ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: EnterWiFiPassword.ViewModel

    var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                NamiChatBubble(I18n.Pairing.EnterWiFiPassword.header.localized(with: viewModel.state.networkName))
                    .padding()
                Spacer()
                NamiTextField(placeholder: I18n.Pairing.EnterWiFiPassword.passwordPlaceholder.localized, text: Binding(get: {
                    viewModel.state.password
                }, set: { value in
                    viewModel.state[keyPath: \.password] = value
                }), returnKeyType: .done)
                    .secureTextEntry(true)
                    .padding()
                Button(I18n.Pairing.EnterWiFiPassword.readyToConnect.localized, action: { viewModel.send(event: .confirmPassword) })
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
                Button(I18n.Pairing.EnterWiFiPassword.goBack.localized, action: { viewModel.send(event: .goBack) })
                    .buttonStyle(NamiActionButtonStyle(rank: .secondary))
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
