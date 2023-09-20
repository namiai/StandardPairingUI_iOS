// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - PowerOnAndScanningView

public struct PowerOnAndScanningView: View {
    // MARK: Lifecycle
    
    public init(viewModel: PowerOnAndScanning.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
    
    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.BluetoothDeviceFound.headerConnectToPower.localized)
                    .font(NamiTextStyle.headline3.font)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair.localized)
                    .font(NamiTextStyle.paragraph1.font)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(I18n.Pairing.PowerOnAndScanning.scanning.localized)
                    .font(NamiTextStyle.headline3.font)
                    .padding(.horizontal)
                Text(I18n.Pairing.PowerOnAndScanning.askUserToWait.localized)
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
}
