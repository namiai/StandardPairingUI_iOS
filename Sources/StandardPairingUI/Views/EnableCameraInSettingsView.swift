
import SwiftUI
import I18n

public struct EnableCameraInSettingsView: View {
    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.ScanQr.title)
                    .font(NamiTextStyle.headline3.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(I18n.Pairing.ScanQr.subtitle)
                    .font(NamiTextStyle.paragraph1.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image("Camera", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text(I18n.Pairing.ScanQrcode.MissingCameraPermission.title)
                    .font(NamiTextStyle.headline3.font)
                Text(I18n.Pairing.ScanQrcode.MissingCameraPermission.description)
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
