// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - BluetoothUsageHintView

public struct BluetoothUsageHintView: View {
    // MARK: Lifecycle

    public init(viewModel: BluetoothUsageHint.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.BluetoothDeviceFound.headerConnectToPower)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding([.horizontal, .top])
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(I18n.Pairing.BluetoothDeviceFound.explainedReadyToPair)
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.send(event: .tapNext)
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: BluetoothUsageHint.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
}
