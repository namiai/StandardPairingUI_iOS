// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - OtherWiFiNetworkView

public struct OtherWiFiNetworkView: View {
    // MARK: Lifecycle
    
    public init(viewModel: OtherWiFiNetwork.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: OtherWiFiNetwork.ViewModel
    @State var nameIsEditing: Bool = false
    @State var passwordIsEditing: Bool = false
    @State var startedEditingFirstTime: Bool = false
    
    public var body: some View {
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
                }),
                              isEditing: $nameIsEditing,
                              returnKeyType: .done)
                .padding()
                NamiTextField(placeholder: I18n.Pairing.EnterWiFiPassword.passwordPlaceholder.localized, text: Binding(get: {
                    viewModel.state.password
                }, set: { value in
                    viewModel.state[keyPath: \.password] = value
                }),
                              isEditing: $passwordIsEditing,
                              returnKeyType: .done)
                .secureTextEntry(true)
                .padding()
                Button(I18n.General.OK.localized, action: { viewModel.send(event: .didConfirmName) })
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
                    .disabled(viewModel.state.networkName.isEmpty)
                Button(I18n.Pairing.OtherWiFiNetwork.backButton.localized, action: { viewModel.send(event: .goBack) })
                    .buttonStyle(NamiActionButtonStyle(rank: .secondary))
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .passwordRetrievalAlert(isPresented: $viewModel.state.shouldAskAboutSavedPassword, networkName: viewModel.state.networkName, viewModel: viewModel)
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
}
