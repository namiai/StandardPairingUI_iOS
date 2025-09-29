// Copyright (c) nami.ai

import I18n
import NamiSharedUIElements
import SharedAssets
import SwiftUI

public struct EnableCameraInSettingsView: View {
    // MARK: Lifecycle

    public init(deviceType: String? = nil) {
        self.deviceType = deviceType ?? ""
    }

    // MARK: Public

    public var body: some View {
        NamiTopNavigationScreen(
            title: isSettingUpKit(wordings: wordingManager.wordings) ? kitName(wordings: wordingManager.wordings) : deviceType,
            colorOverride: themeManager.selectedTheme.navigationBarColor,
            mainContent: {
                VStack {
                    Text(wordingManager.wordings.scanQRtitle)
                        .font(themeManager.selectedTheme.headline3)
                        .foregroundColor(colors.textDefaultPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(wordingManager.wordings.scanQRsubtitle)
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(colors.textDefaultPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    VStack(alignment: .center) {
                        Icons.camera
                            .resizable()
                            .scaledToFit()
                            .frame(width: 128, height: 128)
                        Text(wordingManager.wordings.missingCameraPermissionTitle)
                            .font(themeManager.selectedTheme.headline3)
                            .foregroundColor(colors.textDefaultPrimary)
                        Text(wordingManager.wordings.missingCameraPermissionDescription)
                            .font(themeManager.selectedTheme.paragraph1)
                            .foregroundColor(colors.textDefaultPrimary)
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
        )
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager
    @Environment(\.colors) private var colors

    private var deviceType: String

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
