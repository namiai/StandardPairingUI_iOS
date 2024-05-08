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
                    .font(themeManager.selectedTheme.headline3)
                    .padding([.horizontal, .top])
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair)
                    .font(themeManager.selectedTheme.paragraph1)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(I18n.Pairing.PowerOnAndScanning.scanning)
                    .font(themeManager.selectedTheme.headline3)
                    .padding(.horizontal)
                Text(I18n.Pairing.PowerOnAndScanning.askUserToWait)
                    .font(themeManager.selectedTheme.paragraph1)
                    .padding(.horizontal)
                    .padding(.top, 4)
                if viewModel.state.showsProgressIndicator {
                    ProgressView()
                        .padding()
                }
                Spacer()
            }
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: PowerOnAndScanning.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
}
