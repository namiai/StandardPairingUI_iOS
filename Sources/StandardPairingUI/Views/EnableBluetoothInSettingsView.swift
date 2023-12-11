// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - EnableBluetoothInSettingsView

public struct EnableBluetoothInSettingsView: View {
    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.BluetoothDeviceFound.headerConnectToPower)
                    .font(NamiTextStyle.headline3.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair)
                    .font(NamiTextStyle.paragraph1.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image("Bluetooth", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text(I18n.Pairing.EnableBluetoothInSettings.bluetoothDisabled)
                    .font(NamiTextStyle.headline3.font)
                Text(I18n.Pairing.EnableBluetoothInSettings.header)
                    .font(NamiTextStyle.paragraph1.font)
                Button(I18n.Pairing.EnableBluetoothInSettings.buttonSettings, action: openSettings)
                    .buttonStyle(.borderless)
                    .padding()
                Spacer()
            }
            .padding()
        }
    }

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
}

