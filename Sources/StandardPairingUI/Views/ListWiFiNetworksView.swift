// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - ListWiFiNetworksView

public struct ListWiFiNetworksView: View {
    // MARK: Lifecycle
    
    public init(viewModel: ListWiFiNetworks.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: ListWiFiNetworks.ViewModel
    
    public var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Connect to Wi-Fi network")
                    .font(NamiTextStyle.headline3.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Select a network to connect")
                    .font(NamiTextStyle.paragraph1.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom, .horizontal])
                    .padding(.top, 4)
                
                ScrollView {
                    HStack {
                        if viewModel.state.shouldShowNoNetworksHint {
                            Text(I18n.Pairing.ListWiFiNetworks.noNetworksFound.localized(with: I18n.Pairing.ListWiFiNetworks.otherNetworkButton.localized))
                                .foregroundColor(Color.borderStroke)
                        } else {
                            Text("Available Wi-Fi networks")
                                .foregroundColor(Color.borderStroke)
                        }
                        if viewModel.state.shouldShowProgressView {
                            ProgressView()
                                .padding(.horizontal, 4)
                        }
                        Spacer()
                    }
                    
                    
                    if let networks = viewModel.state.networks {
                        RoundedRectContainerView {
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
                    }
                    otherNetworkRow()
                        .padding(.bottom)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text("Device setup")
        )
        .alert(
            isPresented: $viewModel.state.shouldAskAboutSavedPassword,
            content: alertContent
        )
    }
    
    private func alertContent() -> Alert {
        let networkName = viewModel.state.selectedNetwork?.ssid ?? ""
        return Alert(
            title: Text(I18n.Pairing.ListWiFiNetworks.foundSavedPassword.localized),
            message: Text(I18n.Pairing.ListWiFiNetworks.useSavedPassword.localized(with: networkName)),
            primaryButton:
                    .destructive(Text(I18n.Pairing.ListWiFiNetworks.forget.localized), action: { viewModel.send(event: .didTapForgetPassword) }),
            secondaryButton:
                    .default(Text(I18n.General.OK.localized), action: { viewModel.send(event: .didTapUsePassword) })
        )
    }
    
    private func otherNetworkRow() -> some View {
        RoundedRectContainerView {
            HStack {
                Spacer().frame(width: 24, height: 24)
                Text(I18n.Pairing.ListWiFiNetworks.otherNetworkButton.localized)
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
