// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements

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
                    .padding([.horizontal, .top])
                    .padding(.bottom, 8)
                Text(I18n.Pairing.EnterWifiPassword.header(viewModel.state.networkName))
                    .font(NamiTextStyle.paragraph1.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                NamiTextField(
                    placeholder: I18n.Pairing.EnterWifiPassword.passwordPlaceholder,
                    text: Binding(get: {
                        viewModel.state.password
                    }, set: { value in
                        viewModel.state[keyPath: \.password] = value
                    }),

                    isEditing: $textIsEditing,

                    returnKeyType: .done
                )
                .secureTextEntry(true)
                .subText(I18n.Pairing.EnterWifiPassword.passwordEntryFieldHint)
                .padding()
                .onAppear {
                    textIsEditing = true
                }
                Spacer()
                Button(I18n.Pairing.EnterWifiPassword.buttonReadyToConnect, action: { 
                    // If the keyboard was dismissed already.
                    if textIsEditing == false {
                        viewModel.send(event: .confirmPassword)
                        return
                    }
                    DispatchQueue.main.async {
                        textIsEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { _ in
                        viewModel.send(event: .confirmPassword)
                    }
                })
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
                    .padding()
            }
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: EnterWiFiPassword.ViewModel
    @SwiftUI.State var textIsEditing = false
}
