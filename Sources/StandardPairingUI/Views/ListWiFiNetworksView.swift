// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import SharedAssets

// MARK: - ListWiFiNetworksView

public struct ListWiFiNetworksView: View {
    // MARK: Lifecycle

    public init(viewModel: ListWiFiNetworks.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        NamiTopNavigationScreen(title: navigationBarTitle(),
                                colorOverride: themeManager.selectedTheme.navigationBarColor,
                                contentBehavior: .fixed,
                                mainContent: {
            VStack {
                Text(wordingManager.wordings.connectWifiTitle)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(colors.textDefaultPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
                ScrollView {
                    VStack {
                        HStack {
                            if viewModel.state.shouldShowNoNetworksHint {
                                Text(wordingManager.wordings.networkNotFound)
                                    .font(themeManager.selectedTheme.headline5)
                                    .foregroundColor(colors.textDefaultTertiary)
                            } else {
                                Text(wordingManager.wordings.availableNetworks)
                                    .font(themeManager.selectedTheme.headline5)
                                    .foregroundColor(colors.textDefaultTertiary)
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
                                                    .foregroundStyle(colors.iconDefaultPrimary)
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        })
        .passwordRetrievalAlert(isPresented: $viewModel.state.shouldAskAboutSavedPassword, networkName: viewModel.state.selectedNetwork?.ssid ?? "", viewModel: viewModel, wordingManager: wordingManager)
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @ObservedObject var viewModel: ListWiFiNetworks.ViewModel
    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager
    @Environment(\.colors) private var colors

    // MARK: Private
    
    private func navigationBarTitle() -> String {
        if viewModel.state.setupType == .updateWiFiCreds {
            return I18n.updateWifiTitle
        }
        
        if isSettingUpKit(wordings: wordingManager.wordings) {
            return kitName(wordings: wordingManager.wordings)
        }
        
        return viewModel.state.deviceType != .unknown ? viewModel.state.deviceType.localizedName : I18n.pairingDeviceSetupNavigationTitle
    }
    
    private func otherNetworkRow() -> some View {
        RoundedRectContainerView(backgroundColor: colors.backgroundDefaultSecondary) {
            HStack {
                Spacer().frame(width: 24, height: 24)
                Text(wordingManager.wordings.otherNetworkButton)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(colors.textDefaultPrimary)
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
