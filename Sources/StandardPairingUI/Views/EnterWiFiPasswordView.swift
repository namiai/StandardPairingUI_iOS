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
        DeviceSetupScreen(title: navigationTitle()) {
            VStack {
                Text(wordingManager.wordings.enterPassword(for: viewModel.state.networkName))
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    .padding(.bottom, 8)

                NamiTextField(
                    placeholder: wordingManager.wordings.passwordEntryFieldPlaceholder,
                    text: Binding(get: {
                        viewModel.state.password
                    }, set: { value in
                        viewModel.state[keyPath: \.password] = value
                    }),

                    isEditing: $textIsEditing,

                    returnKeyType: .done,
                    textFieldFont: themeManager.selectedTheme.paragraph1, 
                    subTextFont: themeManager.selectedTheme.paragraph2
                )
                .secureTextEntry(true)
                .subText(wordingManager.wordings.passwordEntryFieldHint)
                .padding()
                .onAppear {
                    textIsEditing = true
                }
                Spacer()
                Button(wordingManager.wordings.buttonReadyToConnect, action: { 
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
                .anyView
                
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            self.isKeyboardAppeared = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.isKeyboardAppeared = false
        }
        .onDisappear {
            self.textIsEditing = false
            self.isKeyboardAppeared = false
        }

    }

    // MARK: Internal

    @ObservedObject var viewModel: EnterWiFiPassword.ViewModel
    @State var textIsEditing = true
    @State private var isKeyboardAppeared: Bool = false
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    
    private func navigationTitle() -> String {
        if !wordingManager.wordings.pairingNavigationBarTitle.isEmpty {
            return wordingManager.wordings.pairingNavigationBarTitle
        }
        
        return viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : I18n.pairingDeviceSetupNavigagtionTitle
    }
}
