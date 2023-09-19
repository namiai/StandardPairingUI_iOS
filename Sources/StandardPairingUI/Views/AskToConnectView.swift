// Copyright (c) nami.ai

import SwiftUI
import Tomonari
import I18n

// MARK: - AskToConnectView

public struct AskToConnectView: View {
    // MARK: Lifecycle
    
    public init(viewModel: AskToConnect.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: AskToConnect.ViewModel
    
    public var body: some View {
        
        DeviceSetupScreen {
                if viewModel.state.doneLoading {
                    VStack {
                        Text(title(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice))
                            .font(NamiTextStyle.headline3.font)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(description(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice))
                            .font(NamiTextStyle.paragraph1.font)
                            .padding(.horizontal)
                            .padding(.top, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    Spacer()
                    Button(I18n.General.next.localized, action: { viewModel.send(event: .tapNext) } )
                        .buttonStyle(NamiActionButtonStyle())
                        .disabled(viewModel.state.nextTapped)
                        .padding()
                } else {
                    DevicePresentingLoadingView(deviceName: viewModel.state.deviceName, deviceModel: viewModel.state.deviceModel)
                }
                
        }
    }
    
    private func title(devicesCount: Int, hasThread: Bool) -> String {
        switch (devicesCount > 0, hasThread) {
        case (true, true):
            return "Remaining Thread devices"
        case (false, true):
            return "Thread border router"
        default:
            return "Connect to Wi-Fi network"
        }
    }
    
    private func description(devicesCount: Int, hasThread: Bool) -> String {
        switch (devicesCount > 0, hasThread) {
        case (true, true):
            return "This device will connect to existing Thread network in the place.\nThe device will connect to the existing Wi-Fi network in the sensing zone."
        case (true, false):
            return "This device will connect to the same Wi-Fi access point used by other devices in \(viewModel.state.zoneName ?? "")\nEnsure your device within 30 ft from the Wi-Fi router"
        case (false, true):
            return "The first Thread device on the sensing zone will be set up as Thread border router.\nYou will need to connect this device to Wi-Fi network, and other devices will use the same network."
        case (false, false):
            return "The access point this device connects to will be used by all other devices in this zone\nSelect the Wi-Fi access pointmost central in the area you want to cover"
        }
    }
}

