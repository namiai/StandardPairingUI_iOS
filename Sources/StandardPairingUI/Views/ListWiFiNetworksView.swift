// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - ListWiFiNetworksView

public struct ListWiFiNetworksView: View {
    // MARK: Lifecycle

    public init(viewModel: ListWiFiNetworks.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            Text(I18n.Pairing.ListWifiNetworks.connectWifiTitle)
                .font(NamiTextStyle.headline3.font)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .top])
            Text(I18n.Pairing.ListWifiNetworks.selectNetwork)
                .font(NamiTextStyle.paragraph1.font)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.bottom, .horizontal])

            ScrollView {
                HStack {
                    if viewModel.state.shouldShowNoNetworksHint {
                        Text(I18n.Pairing.ListWifiNetworks.noNetworksFound)
                            .foregroundColor(Color.borderStroke)
                    } else {
                        Text(I18n.Pairing.ListWifiNetworks.availableNetworks)
                            .font(NamiTextStyle.headline5.font)
                            .foregroundColor(Color.borderStroke)
                    }
                    if viewModel.state.shouldShowProgressView {
                        ProgressView()
                            .padding(.horizontal, 4)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                if let networks = viewModel.state.networks {
                    RoundedRectContainerView {
                        VStack {
                            ForEach(Array(networks.enumerated()), id: \.offset) { item in
                                let i = item.offset
                                let network = item.element
                                VStack {
                                    WiFiNetworkRowView(network: network, selected: network.ssid == viewModel.state.selectedNetwork?.ssid)
                                        .onTapGesture {
                                            viewModel.send(event: .selectNetwofkAndConfirm(network))
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
        .passwordRetrievalAlert(isPresented: $viewModel.state.shouldAskAboutSavedPassword, networkName: viewModel.state.selectedNetwork?.ssid ?? "", viewModel: viewModel)
    }

    // MARK: Internal

    @ObservedObject var viewModel: ListWiFiNetworks.ViewModel

    // MARK: Private

    private func otherNetworkRow() -> some View {
        RoundedRectContainerView {
            HStack {
                Spacer().frame(width: 24, height: 24)
                Text(I18n.Pairing.ListWifiNetworks.buttonOtherNetwork)
                    .font(NamiTextStyle.paragraph1.font)
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
}
