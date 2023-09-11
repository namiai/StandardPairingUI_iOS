// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - EnableBluetoothInSettingsView

public struct EnableBluetoothInSettingsView: View {

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Spacer()
                BluetoothLogo()
                    .padding()
                    .frame(width: 128, height: 128)
                Text("Bluetooth disabled")
                    .font(NamiTextStyle.headline3.font)
                Text(I18n.Pairing.EnableBluetoothInSettings.header.localized)
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                Spacer()
                Button(I18n.Pairing.EnableBluetoothInSettings.settings.localized, action: openSettings)
                    .buttonStyle(NamiActionButtonStyle(rank: .primary))
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

private struct BluetoothLogo: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            let scaleFactor: CGFloat = min(width, height) / 22.0 // Scale to fit within the smaller dimension
            
            Path { path in
                path.move(to: CGPoint(x: 7 * scaleFactor, y: 17 * scaleFactor))
                path.addLine(to: CGPoint(x: 17 * scaleFactor, y: 7 * scaleFactor))
                path.addLine(to: CGPoint(x: 12 * scaleFactor, y: 2 * scaleFactor))
                path.addLine(to: CGPoint(x: 12 * scaleFactor, y: 22 * scaleFactor))
                path.addLine(to: CGPoint(x: 17 * scaleFactor, y: 17 * scaleFactor))
                path.addLine(to: CGPoint(x: 7 * scaleFactor, y: 7 * scaleFactor))
            }
            .stroke(Color.black, lineWidth: scaleFactor)
        }
    }
}

