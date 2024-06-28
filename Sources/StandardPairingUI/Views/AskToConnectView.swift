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
        DeviceSetupScreen(title: wordingManager.wordings.pairingNavigationBarTitle) {
            if viewModel.state.doneLoading {
                VStack {
                    Text(title(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice))
                        .font(themeManager.selectedTheme.headline1)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .padding([.horizontal, .top])
                        .fixedSize(horizontal: false, vertical: true)
                    ForEach(
                        description(devicesCount: viewModel.state.devicesCount, hasThread: viewModel.state.isThreadDevice),
                        id: \.self
                    ) { substring in
                        HStack(alignment: .top) {
                            Text(" - ").font(themeManager.selectedTheme.paragraph1)
                                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                            Text(substring)
                                .font(themeManager.selectedTheme.paragraph1)
                                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .padding()
                Spacer()
                Button(wordingManager.wordings.nextButton, action: { viewModel.send(event: .tapNext) })
                    .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                    .disabled(viewModel.state.nextTapped)
                    .padding(.bottom, NamiActionButtonStyle.ConstraintLayout.BottomToSuperView)
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
    @EnvironmentObject private var wordingManager: WordingManager

    // MARK: Private
    
    private func title(devicesCount: Int, hasThread: Bool) -> String {
        switch (devicesCount > 0, hasThread) {
        // First, Thread.
        case (false, true):
            return wordingManager.wordings.setUpAsBorderRouter
        default:
            return wordingManager.wordings.settingUpThisDevice
        }
    }

    private func description(devicesCount: Int, hasThread: Bool) -> [String] {
        switch (devicesCount > 0, hasThread) {
        // Non-first, Thread.
        case (true, true):
            return [
                wordingManager.wordings.nonFirstThreadDeviceDescription1,
                wordingManager.wordings.nonFirstThreadDeviceDescription2,
                wordingManager.wordings.nonFirstThreadDeviceDescription3(zoneName: viewModel.state.zoneName ?? ""),
            ]
        // Non-first, WiFi.
        case (true, false):
            return [
                wordingManager.wordings.nonFirstWifiDeviceDescription1(zoneName: viewModel.state.zoneName ?? ""),
                measurementSystem == .metric ?
                wordingManager.wordings.wifiDeviceMetricDistanceDescription :
                    wordingManager.wordings.wifiDeviceImperialDistanceDescription,
            ]
        // First, Thread.
        case (false, true):
            return [
                wordingManager.wordings.firstThreadDeviceDescription1,
                wordingManager.wordings.firstThreadDeviceDescription2,
                wordingManager.wordings.firstThreadDeviceDescription3,
            ]
        // First, WiFi
        case (false, false):
            return [
                wordingManager.wordings.firstWifiDeviceDescription1(zoneName: viewModel.state.zoneName ?? ""),
                wordingManager.wordings.firstWifiDeviceDescription2,
                measurementSystem == .metric ?
                wordingManager.wordings.wifiDeviceMetricDistanceDescription :
                    wordingManager.wordings.wifiDeviceImperialDistanceDescription,
            ]
        }
    }
}
