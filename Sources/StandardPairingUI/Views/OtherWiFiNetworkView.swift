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
        DeviceSetupScreen(title: wordingManager.wordings.otherNetworkTitle) {
            VStack {
                Text(wordingManager.wordings.otherWifiNetworkTitle)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal])
                Text(wordingManager.wordings.deviceConnectivityHint)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                NamiTextField(
                    placeholder: wordingManager.wordings.networkNamePlaceholder,
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
                    placeholder: wordingManager.wordings.passwordPlaceholder,
                    text: passwordBinding,
                    isEditing: $passwordIsEditing,
                    returnKeyType: .done,
                    textFieldFont: themeManager.selectedTheme.paragraph1, 
                    subTextFont: themeManager.selectedTheme.small1
                )
                .secureTextEntry(true)
                .padding()
                Spacer()
                Button(wordingManager.wordings.readyToConnectButton, action: { viewModel.send(event: .didConfirmName) })
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
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @ObservedObject var viewModel: OtherWiFiNetwork.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    @State var nameIsEditing = false
    @State var passwordIsEditing = false
    @State var startedEditingFirstTime = false
}
