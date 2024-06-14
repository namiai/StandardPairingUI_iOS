// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements

// MARK: - OtherWiFiNetworkView

public struct OtherWiFiNetworkView: View {
    // MARK: Lifecycle

    public init(viewModel: OtherWiFiNetwork.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                Text(otherWifiNetworkTitle())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal])
                Text(deviceConnectivityHint())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                NamiTextField(
                    placeholder: networkNamePlaceholder(),
                    text: Binding(get: {
                        viewModel.state[keyPath: \.networkName]
                    }, set: { value in
                        viewModel.state[keyPath: \.networkName] = value
                    }),
                    isEditing: $nameIsEditing,
                    returnKeyType: .done,
                    textFieldFont: themeManager.selectedTheme.paragraph1, 
                    subTextFont: themeManager.selectedTheme.small1
                )
                .padding([.top, .horizontal])
                .onAppear {
                    nameIsEditing = true
                }

                let passwordBinding = Binding(get: {
                    viewModel.state.password
                }, set: { value in
                    viewModel.state[keyPath: \.password] = value
                })
                NamiTextField(
                    placeholder: passwordPlaceholder(),
                    text: passwordBinding,
                    isEditing: $passwordIsEditing,
                    returnKeyType: .done,
                    textFieldFont: themeManager.selectedTheme.paragraph1, 
                    subTextFont: themeManager.selectedTheme.small1
                )
                .secureTextEntry(true)
                .padding()
                Spacer()
                Button(readyToConnectButton(), action: { viewModel.send(event: .didConfirmName) })
                    .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                    .disabled(viewModel.state.networkName.isEmpty)
                    .padding()
                    .anyView
            }
        }
        .passwordRetrievalAlert(isPresented: $viewModel.state.shouldAskAboutSavedPassword, networkName: viewModel.state.networkName, viewModel: viewModel, wordingManager: wordingManager)
        .onChange(of: passwordIsEditing) { isEditing in
            if isEditing, viewModel.state.networkName.isEmpty == false, viewModel.state.password.isEmpty, startedEditingFirstTime == false {
                startedEditingFirstTime = true
                viewModel.send(event: .lookForSavedPassword)
            }
        }
        .onChange(of: nameIsEditing) { isEditing in
            if isEditing {
                startedEditingFirstTime = false
            }
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: OtherWiFiNetwork.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    @State var nameIsEditing = false
    @State var passwordIsEditing = false
    @State var startedEditingFirstTime = false
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.Pairing.DeviceSetup.navigagtionTitle
    }
    
    private func otherWifiNetworkTitle() -> String {
        if let customString = wordingManager.wordings.otherWifiNetworkTitle {
            return customString
        }
        
        return I18n.Pairing.OtherWifiNetwork.header
    }
    
    private func deviceConnectivityHint() -> String {
        if let customString = wordingManager.wordings.deviceConnectivityHint {
            return customString
        }
        
        return I18n.Pairing.OtherWifiNetwork.deviceConnectivityHint
    }
    
    private func networkNamePlaceholder() -> String {
        if let customString = wordingManager.wordings.networkNamePlaceholder {
            return customString
        }
        
        return I18n.Pairing.OtherWifiNetwork.networkNamePlaceholder
    }
    
    private func passwordPlaceholder() -> String {
        if let customString = wordingManager.wordings.passwordPlaceholder {
            return customString
        }
        
        return I18n.Pairing.EnterWifiPassword.passwordPlaceholder
    }
    
    private func readyToConnectButton() -> String {
        if let customString = wordingManager.wordings.readyToConnectButton {
            return customString
        }
        
        return I18n.Pairing.EnterWifiPassword.buttonReadyToConnect
    }
}
