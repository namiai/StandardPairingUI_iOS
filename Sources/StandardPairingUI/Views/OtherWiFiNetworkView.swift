// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - OtherWiFiNetworkView

public struct OtherWiFiNetworkView: View {
    // MARK: Lifecycle

    public init(viewModel: OtherWiFiNetwork.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.OtherWifiNetwork.header)
                    .font(NamiTextStyle.headline3.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal])
                Text(I18n.Pairing.OtherWifiNetwork.deviceConnectivityHint)
                    .font(NamiTextStyle.paragraph1.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                NamiTextField(
                    placeholder: I18n.Pairing.OtherWifiNetwork.networkNamePlaceholder,
                    text: Binding(get: {
                        viewModel.state[keyPath: \.networkName]
                    }, set: { value in
                        viewModel.state[keyPath: \.networkName] = value
                    }),
                    isEditing: $nameIsEditing,
                    returnKeyType: .done
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
                    placeholder: I18n.Pairing.EnterWifiPassword.passwordPlaceholder,
                    text: passwordBinding,
                    isEditing: $passwordIsEditing,
                    returnKeyType: .done
                )
                .secureTextEntry(true)
                .padding()
                Spacer()
                Button(I18n.Pairing.EnterWifiPassword.buttonReadyToConnect, action: { viewModel.send(event: .didConfirmName) })
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
                    .disabled(viewModel.state.networkName.isEmpty)
                    .padding()
            }
        }
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

    // MARK: Internal

    @ObservedObject var viewModel: OtherWiFiNetwork.ViewModel
    @State var nameIsEditing = false
    @State var passwordIsEditing = false
    @State var startedEditingFirstTime = false
}
