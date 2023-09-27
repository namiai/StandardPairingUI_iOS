// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - AskToConnectView

public struct AskToConnectView: View {
    // MARK: Lifecycle

    public init(viewModel: AskToConnect.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            if viewModel.state.doneLoading {
                VStack {
                    Text("Setting up this device")
                        .font(NamiTextStyle.headline3.font)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .center)
                    ForEach(
                        description(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice)
                            .split(separator: "\n"),
                        id: \.self
                    ) { substring in
                        HStack(alignment: .top) {
                            Text("・").font(NamiTextStyle.paragraph1.font)
                            Text(description(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice))
                                .font(NamiTextStyle.paragraph1.font)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                }
                .padding()
                Spacer()
                Button(I18n.General.next, action: { viewModel.send(event: .tapNext) })
                    .buttonStyle(NamiActionButtonStyle())
                    .disabled(viewModel.state.nextTapped)
                    .padding()
            } else {
                DevicePresentingLoadingView(deviceName: viewModel.state.deviceName, deviceModel: viewModel.state.deviceModel)
            }
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: AskToConnect.ViewModel

    // MARK: Private

    private func title(devicesCount: Int, hasThread: Bool) -> String {
        switch (devicesCount > 0, hasThread) {
        case (true, true):
            return I18n.Pairing.AskToConnect.remainingThreadDevice
        case (false, true):
            return I18n.Pairing.AskToConnect.threadBorderRouter
        default:
            return I18n.Pairing.AskToConnect.connectToWifi
        }
    }

    private func description(devicesCount: Int, hasThread: Bool) -> String {
        switch (devicesCount > 0, hasThread) {
        case (true, true):
            return I18n.Pairing.AskToConnect.remainingThreadDeviceDescription
        case (true, false):
            return I18n.Pairing.AskToConnect.connectToWifiRemainingDescription(viewModel.state.zoneName ?? "")
        case (false, true):
            return I18n.Pairing.AskToConnect.threadBorderRouterDescription
        case (false, false):
            return I18n.Pairing.AskToConnect.connectToWifiFirstDescription
        }
    }
}
