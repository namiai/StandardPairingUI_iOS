
import SwiftUI
import I18n

public struct EnableCameraInSettingsView: View {
    // MARK: Public
    public init() {
        
    }
    
    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                Text(scanQRTitle())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(scanQRSubtitle())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image("Camera", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text(missingCameraPermissionTitle())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                Text(missingCameraPermissionDescription())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                Button(openSettings(), action: openSettings)
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
    
    private func scanQRTitle() -> String {
        if let customScanQRTitle = wordingManager.wordings.scanDeviceTitle {
            return customScanQRTitle
        }
        
        return I18n.Pairing.ScanQr.title
    }
    
    private func scanQRSubtitle() -> String {
        if let customScanQRSubtitle = wordingManager.wordings.scanDeviceSubtitle {
            return customScanQRSubtitle
        }
        
        return I18n.Pairing.ScanQr.subtitle
    }
    
    private func missingCameraPermissionTitle() -> String {
        if let customWording = wordingManager.wordings.missingCameraPermissionTitle {
            return customWording
        }
        
        return I18n.Pairing.ScanQrcode.MissingCameraPermission.title
    }
    
    private func missingCameraPermissionDescription() -> String {
        if let customWording = wordingManager.wordings.missingCameraPermissionDescription {
            return customWording
        }
        
        return I18n.Pairing.ScanQrcode.MissingCameraPermission.description
    }
    
    private func openSettings() -> String {
        if let customWording = wordingManager.wordings.openSettings {
            return customWording
        }
        
        return I18n.Pairing.EnableBluetoothInSettings.buttonSettings
    }
}
