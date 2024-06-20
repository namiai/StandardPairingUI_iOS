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
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                Text(connectWifiTitle())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                Text(selectNetwork())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom, .horizontal])
                
                ScrollView {
                    HStack {
                        if viewModel.state.shouldShowNoNetworksHint {
                            Text(networkNotFound())
                                .font(themeManager.selectedTheme.headline5)
                                .foregroundColor(themeManager.selectedTheme.tertiaryBlack)
                        } else {
                            Text(availableNetworks())
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
                    
                    if let networks = viewModel.state.networks {
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

    private func otherNetworkRow() -> some View {
        RoundedRectContainerView {
            HStack {
                Spacer().frame(width: 24, height: 24)
                Text(I18n.pairingListWifiNetworksButtonOtherNetwork)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .onTapGesture {
            viewModel.send(event: .tappedOtherNetwork)
        }
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.pairingDeviceSetupNavigagtionTitle
    }
    
    private func connectWifiTitle() -> String {
        if let customString = wordingManager.wordings.connectWifiTitle {
            return customString
        }
        
        return I18n.pairingListWifiNetworksConnectWifiTitle
    }
    
    private func selectNetwork() -> String {
        if let customString = wordingManager.wordings.selectNetwork {
            return customString
        }
        
        return I18n.pairingListWifiNetworksSelectNetwork
    }
    
    private func networkNotFound() -> String {
        if let customString = wordingManager.wordings.networkNotFound {
            return customString
        }
        
        return I18n.pairingListWifiNetworksNoNetworksFound
    }
    
    private func availableNetworks() -> String {
        if let customString = wordingManager.wordings.availableNetworks {
            return customString
        }
        
        return I18n.pairingListWifiNetworksAvailableNetworks
    }
    
    private func otherNetworkButton() -> String {
        if let customString = wordingManager.wordings.otherNetworkButton {
            return customString
        }
        
        return I18n.pairingListWifiNetworksButtonOtherNetwork
    }
}
