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
        DeviceSetupScreen(title: titleWording()) {
            if viewModel.state.doneLoading {
                VStack {
                    Text(title(devicesCount: viewModel.state.devicesCount, hasBorderRouter: viewModel.state.hasBorderRouter, hasThread: viewModel.state.isThreadDevice))
                        .font(themeManager.selectedTheme.headline1)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .padding([.horizontal, .top])
                        .fixedSize(horizontal: false, vertical: true)
                    VStack(alignment: .leading) {
                        ForEach(
                            description(devicesCount: viewModel.state.devicesCount, hasBorderRouter: viewModel.state.hasBorderRouter, hasThread: viewModel.state.isThreadDevice),
                            id: \.self
                        ) { substring in   
                                HStack(alignment: .top) {
                                    Text(" - ").font(themeManager.selectedTheme.paragraph1)
                                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                                        .frame(width: 20)
                                    Text(substring)
                                        .font(themeManager.selectedTheme.paragraph1)
                                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
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
    @EnvironmentObject private var wordingManager: WordingManager

    // MARK: Private
    
    private func title(devicesCount: Int, hasBorderRouter: Bool, hasThread: Bool) -> String {
        switch (devicesCount > 0, hasThread) {
        // First, Thread.
        case (false, true):
            return wordingManager.wordings.setUpAsBorderRouter != nil ? wordingManager.wordings.setUpAsBorderRouter! : I18n.Pairing.ConnectWifi.setUpAsBorderRouter
        default:
            if hasBorderRouter {
                return wordingManager.wordings.settingUpThisDevice != nil ? wordingManager.wordings.settingUpThisDevice! : I18n.Pairing.ConnectWifi.settingUpThisDevice
            } else {
                return wordingManager.wordings.setUpAsBorderRouter != nil ? wordingManager.wordings.setUpAsBorderRouter! : I18n.Pairing.ConnectWifi.setUpAsBorderRouter    
            }
        }
    }

    private func description(devicesCount: Int, hasBorderRouter: Bool, hasThread: Bool) -> [String] {
        switch (devicesCount > 0, hasThread) {
        // Non-first, Thread.
        case (true, true):
            if hasBorderRouter {
                return [
                    nonFirstThreadDeviceDesc1(),
                    nonFirstThreadDeviceDesc2(),
                    nonFirstThreadDeviceDesc3(),
                ]
            } else {
                return [
                    firstThreadDeviceDescription1(),
                    firstThreadDeviceDescription2(),
                    firstThreadDeviceDescription3(),
                ]
            }
        // Non-first, WiFi.
        case (true, false):
            return [
                nonFirstWifiDeviceDesc1(),
                measurementSystem == .metric ?
                    wifiDeviceMetricDistanceDescription() :
                    wifiDeviceImperialDistanceDescription(),
            ]
        // First, Thread.
        case (false, true):
            return [
                firstThreadDeviceDescription1(),
                firstThreadDeviceDescription2(),
                firstThreadDeviceDescription3(),
            ]
        // First, WiFi
        case (false, false):
            return [
                firstWifiDeviceDescription1(),
                firstWifiDeviceDescription2(),
                measurementSystem == .metric ?
                    wifiDeviceMetricDistanceDescription() :
                    wifiDeviceImperialDistanceDescription(),
            ]
        }
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.Pairing.DeviceSetup.navigagtionTitle
    }
    
    private func nonFirstThreadDeviceDesc1() -> String {
        if let customString = wordingManager.wordings.nonFirstThreadDeviceDescription1 {
            return customString
        }
        
        return I18n.Pairing.AskToConnect.NonFirstThreadDevice.description1
    }
    
    private func nonFirstThreadDeviceDesc2() -> String {
        if let customString = wordingManager.wordings.nonFirstThreadDeviceDescription2 {
            return customString
        }
        
        return I18n.Pairing.AskToConnect.NonFirstThreadDevice.description2
    }
    
    private func nonFirstThreadDeviceDesc3() -> String {
        if let customString = wordingManager.wordings.nonFirstThreadDeviceDescription3 {
            return String.localizedStringWithFormat(customString, viewModel.state.zoneName ?? "")
        }
        
        return I18n.Pairing.AskToConnect.NonFirstThreadDevice.description3(viewModel.state.zoneName ?? "")
    }
    
    private func nonFirstWifiDeviceDesc1() -> String {
        if let customString = wordingManager.wordings.nonFirstWifiDeviceDescription1 {
            return String.localizedStringWithFormat(customString, viewModel.state.zoneName ?? "")
        }
        
        return I18n.Pairing.AskToConnect.NonFirstWifiDevice.description1(viewModel.state.zoneName ?? "")
    }
    
    private func wifiDeviceMetricDistanceDescription() -> String {
        if let customString = wordingManager.wordings.wifiDeviceMetricDistanceDescription {
            return customString
        }
        
        return I18n.Pairing.AskToConnect.WifiDeviceMetricDistance.description
    }
    
    private func wifiDeviceImperialDistanceDescription() -> String {
        if let customString = wordingManager.wordings.wifiDeviceImperialDistanceDescription {
            return customString
        }
        
        return I18n.Pairing.AskToConnect.WifiDeviceImperialDistance.description
    }
    
    private func firstThreadDeviceDescription1() -> String {
        if let customString = wordingManager.wordings.firstThreadDeviceDescription1 {
            return customString
        }
        
        return I18n.Pairing.AskToConnect.FirstThreadDevice.description1
    }
    
    private func firstThreadDeviceDescription2() -> String {
        if let customString = wordingManager.wordings.firstThreadDeviceDescription2 {
            return customString
        }
        
        return I18n.Pairing.AskToConnect.FirstThreadDevice.description2
    }
    
    private func firstThreadDeviceDescription3() -> String {
        if let customString = wordingManager.wordings.firstThreadDeviceDescription3 {
            return customString
        }
        
        return I18n.Pairing.AskToConnect.FirstThreadDevice.description3
    }
    
    private func firstWifiDeviceDescription1() -> String {
        if let customString = wordingManager.wordings.firstWifiDeviceDescription1 {
            return String.localizedStringWithFormat(customString, viewModel.state.zoneName ?? "")
        }
        
        return I18n.Pairing.AskToConnect.FirstWifiDevice.description1(viewModel.state.zoneName ?? "")
    }
    
    private func firstWifiDeviceDescription2() -> String {
        if let customString = wordingManager.wordings.firstWifiDeviceDescription2 {
            return customString
        }
        
        return I18n.Pairing.AskToConnect.FirstWifiDevice.description2
    }
}
