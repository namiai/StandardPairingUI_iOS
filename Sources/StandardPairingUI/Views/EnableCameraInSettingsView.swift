
import SwiftUI
import I18n

public struct EnableCameraInSettingsView: View {
    // MARK: Public

    public var body: some View {
        DeviceSetupScreen(title: I18n.Pairing.DeviceSetup.navigagtionTitle) {
            VStack {
                Text(I18n.Pairing.ScanQr.title)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(I18n.Pairing.ScanQr.subtitle)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image("Camera", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text(I18n.Pairing.ScanQrcode.MissingCameraPermission.title)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                Text(I18n.Pairing.ScanQrcode.MissingCameraPermission.description)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
