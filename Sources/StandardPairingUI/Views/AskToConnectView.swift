// Copyright (c) nami.ai

import CommonTypes
import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements

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
                    Text(title(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice))
                        .font(themeManager.selectedTheme.headline1)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .padding([.horizontal, .top])
                        .frame(maxWidth: .infinity, alignment: .center)
                    ForEach(
                        description(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice),
                        id: \.self
                    ) { substring in
                        HStack(alignment: .top) {
                            Text("・").font(themeManager.selectedTheme.paragraph1)
                                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                            Text(substring)
                                .font(themeManager.selectedTheme.paragraph1)
                                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .padding()
                Spacer()
                Button(I18n.General.next, action: { viewModel.send(event: .tapNext) })
                    .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                    .disabled(viewModel.state.nextTapped)
                    .padding()
                    .anyView
            } else {
                DevicePresentingLoadingView(deviceName: viewModel.state.deviceName, deviceModel: viewModel.state.deviceModel)
            }
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: AskToConnect.ViewModel
    @Environment(\.measurementSystem) var measurementSystem: MeasurementSystem
    @EnvironmentObject private var themeManager: ThemeManager

    // MARK: Private
    
    private func title(devicesCount: Int, hasThread: Bool) -> String {
        switch (devicesCount > 0, hasThread) {
        // First, Thread.
        case (false, true):
            return I18n.Pairing.ConnectWifi.setUpAsBorderRouter
        default:
            return I18n.Pairing.ConnectWifi.settingUpThisDevice
        }
    }

    private func description(devicesCount: Int, hasThread: Bool) -> [String] {
        switch (devicesCount > 0, hasThread) {
        // Non-first, Thread.
        case (true, true):
            return [
                I18n.Pairing.AskToConnect.NonFirstThreadDevice.description1,
                I18n.Pairing.AskToConnect.NonFirstThreadDevice.description2,
                I18n.Pairing.AskToConnect.NonFirstThreadDevice.description3(viewModel.state.zoneName ?? ""),
            ]
        // Non-first, WiFi.
        case (true, false):
            return [
                I18n.Pairing.AskToConnect.NonFirstWifiDevice.description1(viewModel.state.zoneName ?? ""),
                measurementSystem == .metric ?
                    I18n.Pairing.AskToConnect.WifiDeviceMetricDistance.description :
                    I18n.Pairing.AskToConnect.WifiDeviceImperialDistance.description,
            ]
        // First, Thread.
        case (false, true):
            return [
                I18n.Pairing.AskToConnect.FirstThreadDevice.description1,
                I18n.Pairing.AskToConnect.FirstThreadDevice.description2,
                I18n.Pairing.AskToConnect.FirstThreadDevice.description3,
            ]
        // First, WiFi
        case (false, false):
            return [
                I18n.Pairing.AskToConnect.FirstWifiDevice.description1(viewModel.state.zoneName ?? ""),
                I18n.Pairing.AskToConnect.FirstWifiDevice.description2,
                measurementSystem == .metric ?
                    I18n.Pairing.AskToConnect.WifiDeviceMetricDistance.description :
                    I18n.Pairing.AskToConnect.WifiDeviceImperialDistance.description,
            ]
        }
    }
}
