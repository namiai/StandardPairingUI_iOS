// Copyright (c) nami.ai

import CommonTypes
import I18n
import SwiftUI

// MARK: - DevicePresentingLoadingView

struct DevicePresentingLoadingView: View {
    // MARK: Lifecycle

    init(deviceName: String, deviceModel: NamiDeviceModel) {
        self.deviceName = deviceName
        self.deviceModel = deviceModel
    }

    // MARK: Internal

    var body: some View {
        VStack {
            Spacer()
            DeviceImages.image(for: deviceModel.codeName)
                .resizable()
                .scaledToFit()
                .padding()

            Text(connectingToDevice())
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)

            ProgressView()
            Spacer()
        }
    }

    // MARK: Private
    
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    private var deviceName: String
    private var deviceModel: NamiDeviceModel
    
    private func connectingToDevice() -> String {
        if let customWording = wordingManager.wordings.connectingToDevice {
            return String.localizedStringWithFormat(customWording, deviceName)
        }
        
        return I18n.pairingLoadingDeviceConnecting(deviceName)
    }
}

// MARK: - DevicePresentingLoadingView_Previews

struct DevicePresentingLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        DevicePresentingLoadingView(deviceName: "Plug in the living room", deviceModel: .unknown)
    }
}
