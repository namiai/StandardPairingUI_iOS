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
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                Text(enterPassword())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    .padding(.bottom, 8)
                Text(enterPasswordHeader())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                NamiTextField(
                    placeholder: passwordFieldPlaceholder(),
                    text: Binding(get: {
                        viewModel.state.password
                    }, set: { value in
                        viewModel.state[keyPath: \.password] = value
                    }),

                    isEditing: $textIsEditing,

                    returnKeyType: .done,
                    textFieldFont: themeManager.selectedTheme.paragraph1, 
                    subTextFont: themeManager.selectedTheme.small1
                )
                .secureTextEntry(true)
                .subText(passwordFieldHint())
                .padding()
                .onAppear {
                    textIsEditing = true
                }
                Spacer()
                Button(buttonReadyToConnect(), action: { 
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
                .padding()
                .anyView
            }
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: EnterWiFiPassword.ViewModel
    @SwiftUI.State var textIsEditing = false
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.pairingDeviceSetupNavigagtionTitle
    }
    
    private func enterPassword() -> String {
        if let customString = wordingManager.wordings.enterPassword {
            return customString
        }
        
        return I18n.pairingEnterWifiPasswordEnterPassword
    }
    
    private func enterPasswordHeader() -> String {
        if let customString = wordingManager.wordings.enterPasswordHeaderTitle {
            return customString
        }
        
        return I18n.pairingEnterWifiPasswordHeader(viewModel.state.networkName)
    }
    
    private func passwordFieldPlaceholder() -> String {
        if let customString = wordingManager.wordings.passwordEntryFieldPlaceholder {
            return customString
        }
        
        return I18n.pairingEnterWifiPasswordPasswordPlaceholder
    }
    
    private func passwordFieldHint() -> String {
        if let customString = wordingManager.wordings.passwordEntryFieldHint {
            return customString
        }
        
        return I18n.pairingEnterWifiPasswordPasswordEntryFieldHint
    }
    
    private func buttonReadyToConnect() -> String {
        if let customString = wordingManager.wordings.buttonReadyToConnect {
            return customString
        }
        
        return I18n.pairingEnterWifiPasswordButtonReadyToConnect
    }
    
}
