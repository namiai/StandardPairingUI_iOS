// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - BluetoothUsageHintView

public struct BluetoothUsageHintView: View {
    // MARK: Lifecycle
    
    public init(viewModel: BluetoothUsageHint.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: BluetoothUsageHint.ViewModel
    
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
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.send(event: .tapNext)
        }
    }
}
