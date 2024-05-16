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
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    .padding(.bottom, 8)
                Text(I18n.Pairing.EnterWifiPassword.header(viewModel.state.networkName))
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
                .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                .padding(.bottom, isKeyboardAppeared ? NamiActionButtonStyle.ConstraintLayout.BottomTokeyboard : NamiActionButtonStyle.ConstraintLayout.BottomToSuperView)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    self.isKeyboardAppeared = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    self.isKeyboardAppeared = false
                }
                .anyView
            }
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: EnterWiFiPassword.ViewModel
    @SwiftUI.State var textIsEditing = false
    @SwiftUI.State private var isKeyboardAppeared: Bool = false
    @EnvironmentObject private var themeManager: ThemeManager
}
