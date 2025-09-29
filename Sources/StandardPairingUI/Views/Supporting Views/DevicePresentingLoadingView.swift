// Copyright (c) nami.ai

import CommonTypes
import I18n
import SharedAssets
import SwiftUI

// MARK: - DevicePresentingLoadingView

struct DevicePresentingLoadingView: View {
    // MARK: Lifecycle

    init(deviceName: String, deviceModel: NamiDeviceModel) {
        self.deviceName = deviceName
        self.deviceModel = deviceModel
    }

    // MARK: Internal

    @Environment(\.colors) var colors: Colors

    var body: some View {
        VStack {
            Spacer()
            DeviceImages.image(for: deviceModel.codeName)
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
                .padding()

            Text(wordingManager.wordings.connectingToDevice(deviceName: deviceName))
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(colors.textDefaultPrimary)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)

            ProgressView()
            Spacer()
        }
    }

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager

    private var deviceName: String
    private var deviceModel: NamiDeviceModel
}

// MARK: - DevicePresentingLoadingView_Previews

struct DevicePresentingLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        DevicePresentingLoadingView(deviceName: "Plug in the living room", deviceModel: .unknown)
    }
}
