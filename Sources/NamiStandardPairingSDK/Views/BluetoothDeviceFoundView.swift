// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - BluetoothDeviceFoundView

struct BluetoothDeviceFoundView: View {
    // MARK: Lifecycle

    init(viewModel: BluetoothDeviceFound.ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: BluetoothDeviceFound.ViewModel

    var body: some View {
        ZStack {
            Color.lowerBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                if let modelTitle = viewModel.state.deviceModel?.productLabel {
                    NamiChatBubble(I18n.Pairing.BluetoothDeviceFound.header1Known.localized(with: modelTitle))
                        .padding()
                } else {
                    NamiChatBubble(I18n.Pairing.BluetoothDeviceFound.header1.localized)
                        .padding()
                }
                NamiChatBubble(I18n.Pairing.BluetoothDeviceFound.header2.localized)
                    .padding()
                ProgressView()
                if let codeName = viewModel.state.deviceModel?.codeName {
                    DeviceImages.image(for: codeName)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
