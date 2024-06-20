// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements
import SharedAssets

// MARK: - PowerOnAndScanningView

public struct PowerOnAndScanningView: View {
    // MARK: Lifecycle

    public init(viewModel: PowerOnAndScanning.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            // support multiple devicetypes
            if viewModel.state.deviceTypes.count > 1 {
                self.GeneralDeviceTypeScanning()
            } else {
                switch viewModel.state.deviceTypes.first {
                case .contactSensor:
                    self.ContactSensorDeviceTypeScanning()
                default:
                    self.GeneralDeviceTypeScanning()
                }
            }
        }
    }
    
    // MARK: Internal

    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
    
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.pairingDeviceSetupNavigagtionTitle
    }
    
    private func headerConnectToPower() -> String {
        if let customHeaderConnectToPower = wordingManager.wordings.headerConnectToPower {
            return customHeaderConnectToPower
        }
        
        return I18n.pairingBluetoothDeviceFoundHeaderConnectToPower
    }
    
    private func explainedReadyToPair() -> String {
        if let customExplainedReadyToPair = wordingManager.wordings.explainedReadyToPair {
            return customExplainedReadyToPair
        }
        
        return I18n.pairingBluetoothDeviceFoundExplainedReadyToPair
    }
    
    private func scanning() -> String {
        if let customScanning = wordingManager.wordings.scanning {
            return customScanning
        }
        
        return I18n.pairingPowerOnAndScanningScanning
    }
    
    private func askUserToWait() -> String {
        if let customAskUserToWait = wordingManager.wordings.askUserToWait {
            return customAskUserToWait
        }
        
        return I18n.pairingPowerOnAndScanningAskUserToWait
    }
    
    @ViewBuilder
    private func GeneralDeviceTypeScanning() -> some View {
        VStack {
            Text(headerConnectToPower())
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(explainedReadyToPair())
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(scanning())
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
            Text(askUserToWait())
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
                .padding(.top, 4)
            if viewModel.state.showsProgressIndicator {
                ProgressView()
                    .padding()
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func ContactSensorDeviceTypeScanning() -> some View {
        VStack {
            Text(I18n.Pairing.BluetoothDeviceFound.headerContactSensor)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LottieAnimationView(animation: \.contactSensorPulsingDarkBlue)
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 16)
            
            Text(I18n.Pairing.PowerOnAndScanning.scanning)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
            
            Text(I18n.Pairing.PowerOnAndScanning.askUserToWait)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
            
            if viewModel.state.showsProgressIndicator {
                ProgressView()
                    .padding()
            }
            Spacer()
            if #available(iOS 15, *) {
                NamiTextHyperLink(text: I18n.Pairing.BluetoothDeviceFound.FAQContactSensor, link: URLLinks.FAQNotPulsingBlue, linkColor: themeManager.selectedTheme.primaryBlack)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            } else {
                NamiTextHyperLinkLegacy(text: I18n.Pairing.BluetoothDeviceFound.FAQContactSensor, link: URLLinks.FAQNotPulsingBlue, linkColor: themeManager.selectedTheme.primaryBlack)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            }
        }
    }
}
