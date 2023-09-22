// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - EnterWiFiPasswordView

public struct EnterWiFiPasswordView: View {
    // MARK: Lifecycle

    public init(viewModel: EnterWiFiPassword.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.EnterWifiPassword.enterPassword)
                    .font(NamiTextStyle.headline3.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text(I18n.Pairing.EnterWifiPassword.header( viewModel.state.networkName))
                    .font(NamiTextStyle.paragraph1.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom)
                NamiTextField(placeholder: I18n.Pairing.EnterWifiPassword.passwordPlaceholder, text: Binding(get: {
                    viewModel.state.password
                }, set: { value in
                    viewModel.state[keyPath: \.password] = value
                }), returnKeyType: .done)
                    .secureTextEntry(true)
                    .subText(I18n.Pairing.EnterWifiPassword.passwordEntryFieldHint)
                    .padding()
                Spacer()
                Button(I18n.Pairing.EnterWifiPassword.buttonReadyToConnect, action: { viewModel.send(event: .confirmPassword) })
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
            }
            .padding()
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: EnterWiFiPassword.ViewModel
}
