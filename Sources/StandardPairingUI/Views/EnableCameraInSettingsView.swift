
import SwiftUI
import I18n

public struct EnableCameraInSettingsView: View {
    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.ScanQr.title)
                    .font(themeManager.selectedTheme.headline3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(I18n.Pairing.ScanQr.subtitle)
                    .font(themeManager.selectedTheme.paragraph1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image("Camera", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text(I18n.Pairing.ScanQrcode.MissingCameraPermission.title)
                    .font(themeManager.selectedTheme.headline3)
                Text(I18n.Pairing.ScanQrcode.MissingCameraPermission.description)
                    .font(themeManager.selectedTheme.paragraph1)
                Button(I18n.Pairing.EnableBluetoothInSettings.buttonSettings, action: openSettings)
                    .buttonStyle(.borderless)
                    .padding()
                Spacer()
            }
            .padding()
        }
    }
    
    @EnvironmentObject private var themeManager: ThemeManager

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
