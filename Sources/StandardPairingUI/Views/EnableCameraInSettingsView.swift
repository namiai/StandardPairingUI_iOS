
import SwiftUI
import I18n

public struct EnableCameraInSettingsView: View {
    // MARK: Public
    public init(deviceType: String? = nil) {
        self.deviceType = deviceType ?? ""
    }
    
    public var body: some View {
        DeviceSetupScreen(title: self.deviceType.isEmpty ? wordingManager.wordings.pairingNavigationBarTitle : self.deviceType) {
            VStack {
                Text(wordingManager.wordings.scanQRtitle)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(wordingManager.wordings.scanQRsubtitle)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack(alignment: .center) {
                    Image("Camera", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 128)
                    Text(wordingManager.wordings.missingCameraPermissionTitle)
                        .font(themeManager.selectedTheme.headline3)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    Text(wordingManager.wordings.missingCameraPermissionDescription)
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(themeManager.selectedTheme.primaryBlack)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    Button(wordingManager.wordings.openSettings, action: openSettings)
                        .buttonStyle(.borderless)
                        .padding()
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.keyboard)
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
    
    private var deviceType: String
}
