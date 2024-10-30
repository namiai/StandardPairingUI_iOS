// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements
import SharedAssets

// MARK: - ListWiFiNetworksView

public struct ListWiFiNetworksView: View {
    // MARK: Lifecycle

    public init(viewModel: ListWiFiNetworks.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen(title: navigationTitle()) {
            VStack {
                Text(wordingManager.wordings.connectWifiTitle)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
                ScrollView {
                    HStack {
                        if viewModel.state.shouldShowNoNetworksHint {
                            Text(wordingManager.wordings.networkNotFound)
                                .font(themeManager.selectedTheme.headline5)
                                .foregroundColor(themeManager.selectedTheme.tertiaryBlack)
                        } else {
                            Text(wordingManager.wordings.availableNetworks)
                                .font(themeManager.selectedTheme.headline5)
                                .foregroundColor(themeManager.selectedTheme.tertiaryBlack)
                        }
                        if viewModel.state.shouldShowProgressView {
                            ProgressView()
                                .padding(.horizontal, 4)
                        }
                        Spacer()
                    }
                    .padding([.horizontal, .bottom])
                    
                    if let networks = viewModel.state.networks, networks.isEmpty == false {
                        RoundedRectContainerView {
                            VStack {
                                ForEach(Array(networks.enumerated()), id: \.offset) { item in
                                    let i = item.offset
                                    let network = item.element
                                    VStack {
                                        WiFiNetworkRowView(network: network)
                                            .onTapGesture {
                                                viewModel.send(event: .selectNetworkAndConfirm(network))
                                            }
                                        if i < networks.count - 1 {
                                            Divider()
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .padding(.horizontal)
                    }
                    
                    if viewModel.state.couldShowAddOtherNetwork {
                        if viewModel.state.networks?.isEmpty ?? true {
                            Spacer().frame(height: 12)
                        }
                        otherNetworkRow()
                            .padding([.horizontal, .bottom])
                    }
                }
            }
        }
        .passwordRetrievalAlert(isPresented: $viewModel.state.shouldAskAboutSavedPassword, networkName: viewModel.state.selectedNetwork?.ssid ?? "", viewModel: viewModel, wordingManager: wordingManager)
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @ObservedObject var viewModel: ListWiFiNetworks.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    // MARK: Private
    
    private func navigationTitle() -> String {
        if let kit = viewModel.state.kit { 
            switch kit {
            case .bss:
                return wordingManager.wordings.basicSecuritySystem
            case .hms:
                return wordingManager.wordings.homeSecuritySystem
            }
        }
        
        return viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : wordingManager.wordings.pairingNavigationBarTitle
    }

    private func otherNetworkRow() -> some View {
        RoundedRectContainerView {
            HStack {
                Spacer().frame(width: 24, height: 24)
                Text(wordingManager.wordings.otherNetworkButton)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            viewModel.send(event: .tappedOtherNetwork)
        }
    }
}
