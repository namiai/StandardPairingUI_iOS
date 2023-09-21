// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - EnterWiFiPasswordView

public struct EnterWiFiPasswordView: View {
    // MARK: Lifecycle

    public init(viewModel: EnterWiFiPassword.ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: EnterWiFiPassword.ViewModel

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.EnterWiFiPassword.enterPassword.localized)
                    .font(NamiTextStyle.headline3.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text(I18n.Pairing.EnterWiFiPassword.header.localized(with: viewModel.state.networkName))
                    .font(NamiTextStyle.paragraph1.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom)
                NamiTextField(placeholder: I18n.Pairing.EnterWiFiPassword.passwordPlaceholder.localized, text: Binding(get: {
                    viewModel.state.password
                }, set: { value in
                    viewModel.state[keyPath: \.password] = value
                }), returnKeyType: .done)
                    .secureTextEntry(true)
                    .subText(I18n.Pairing.EnterWiFiPassword.passwordEntryFieldHint.localized)
                    .padding()
                Spacer()
                Button(I18n.Pairing.EnterWiFiPassword.readyToConnect.localized, action: { viewModel.send(event: .confirmPassword) })
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
            }
            .padding()
        }
    }
}
