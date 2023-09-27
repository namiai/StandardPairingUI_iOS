// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import CommonTypes

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
                    Text(I18n.Pairing.ConnectWifi.settingUpThisDevice)
                        .font(NamiTextStyle.headline3.font)
                        .padding([.horizontal, .top])
                        .frame(maxWidth: .infinity, alignment: .center)
                    ForEach(
                        description(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice),
                        id: \.self
                    ) { substring in
                        HStack(alignment: .top) {
                            Text("・").font(NamiTextStyle.paragraph1.font)
                            Text(substring)
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
    @Environment(\.measurementSystem) var measurementSystem: MeasurementSystem

    // MARK: Private

    private func description(devicesCount: Int, hasThread: Bool) -> [String] {
        switch (devicesCount > 0, hasThread) {
            // Non-first, Thread.
        case (true, true):
            return [I18n.Pairing.AskToConnect.remainingThreadDeviceDescription]
            // Non-first, WiFi.
        case (true, false):
            return [I18n.Pairing.AskToConnect.connectToWifiRemainingDescription(viewModel.state.zoneName ?? "")]
            // First, Thread.
        case (false, true):
            return [I18n.Pairing.AskToConnect.threadBorderRouterDescription]
            // First, WiFi
        case (false, false):
            return [I18n.Pairing.AskToConnect.connectToWifiFirstDescription]
        }
    }
}
