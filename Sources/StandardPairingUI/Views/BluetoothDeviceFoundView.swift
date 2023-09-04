// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - BluetoothDeviceFoundView

public struct BluetoothDeviceFoundView: View {
    // MARK: Lifecycle

    public init(viewModel: BluetoothDeviceFound.ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: BluetoothDeviceFound.ViewModel

    public var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                if let codeName = viewModel.state.deviceModel?.codeName {
                    DeviceImages.image(for: codeName)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                if let modelTitle = viewModel.state.deviceModel?.productLabel {
                    Text(I18n.Pairing.BluetoothDeviceFound.header1Known.localized(with: modelTitle))
                        .font(NamiTextStyle.headline3.font)
                        .padding(.horizontal)
                } else {
                    Text(I18n.Pairing.BluetoothDeviceFound.header1.localized)
                        .padding(.horizontal)
                }
                Text(I18n.Pairing.BluetoothDeviceFound.header2.localized)
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .padding(.top, 4)
                ProgressView()
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text("Device setup")
        )
    }
}
