// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - PowerOnAndScanningView

public struct PowerOnAndScanningView: View {
    // MARK: Lifecycle

    public init(viewModel: PowerOnAndScanning.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.BluetoothDeviceFound.headerConnectToPower)
                    .font(NamiTextStyle.headline3.font)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair)
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(I18n.Pairing.PowerOnAndScanning.scanning)
                    .font(NamiTextStyle.headline3.font)
                    .padding(.horizontal)
                Text(I18n.Pairing.PowerOnAndScanning.askUserToWait)
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .padding(.top, 4)
                if viewModel.state.showsProgressIndicator {
                    ProgressView()
                        .padding()
                }
                Spacer()
            }
            .padding()
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
}
