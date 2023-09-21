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

            Text(I18n.Pairing.LoadingDevice.connecting.localized(with: deviceName))
                .font(NamiTextStyle.headline3.font)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)

            ProgressView()
            Spacer()
        }
    }

    // MARK: Private

    private var deviceName: String
    private var deviceModel: NamiDeviceModel
}

// MARK: - DevicePresentingLoadingView_Previews

struct DevicePresentingLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        DevicePresentingLoadingView(deviceName: "Plug in the living room", deviceModel: .unknown)
    }
}
