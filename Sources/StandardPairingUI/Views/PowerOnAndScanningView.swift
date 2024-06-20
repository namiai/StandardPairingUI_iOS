// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - PowerOnAndScanningView

public struct PowerOnAndScanningView: View {
    // MARK: Lifecycle

    public init(viewModel: PowerOnAndScanning.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
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
    
}
