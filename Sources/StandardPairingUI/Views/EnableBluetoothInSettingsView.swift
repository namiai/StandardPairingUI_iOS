// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - EnableBluetoothInSettingsView

public struct EnableBluetoothInSettingsView: View {
    // MARK: Public

    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                Text(headerConnectToPower())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(explainedReadyToPair())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image("Bluetooth", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text(bluetoothDisabled())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                Text(enableBlueToothInSettingsHeader())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                Button(buttonSettings(), action: openSettings)
                    .buttonStyle(.borderless)
                    .padding()
                Spacer()
            }
            .padding()
        }
    }
    
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    // MARK: Private

    private func openSettings() {
        guard
            let settings = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settings)
        else {
            return
        }

        UIApplication.shared.open(settings, completionHandler: nil)
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.Pairing.DeviceSetup.navigagtionTitle
    }
    
    private func headerConnectToPower() -> String {
        if let customHeaderConnectToPower = wordingManager.wordings.headerConnectToPower {
            return customHeaderConnectToPower
        }
        
        return I18n.Pairing.BluetoothDeviceFound.headerConnectToPower
    }
    
    private func explainedReadyToPair() -> String {
        if let customExplainedReadyToPair = wordingManager.wordings.explainedReadyToPair {
            return customExplainedReadyToPair
        }
        
        return I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair
    }
    
    private func bluetoothDisabled() -> String {
        if let customWording = wordingManager.wordings.bluetoothDisabled {
            return customWording
        }
        
        return I18n.Pairing.EnableBluetoothInSettings.bluetoothDisabled
    }
    
    private func enableBlueToothInSettingsHeader() -> String {
        if let customWording = wordingManager.wordings.enableBlueToothInSettingsHeader {
            return customWording
        }
        
        return I18n.Pairing.EnableBluetoothInSettings.header
    }
    
    private func buttonSettings() -> String {
        if let customWording = wordingManager.wordings.buttonSettings {
            return customWording
        }
        
        return I18n.Pairing.EnableBluetoothInSettings.buttonSettings
    }    
}

