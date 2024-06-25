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
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                Text(headerConnectToPower())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .padding([.horizontal, .top])
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(explainedReadyToPair())
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
    @EnvironmentObject private var wordingManager: WordingManager
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.pairingDeviceSetupNavigagtionTitle
    }
    
    private func headerConnectToPower() -> String {
        if let customHeaderConnectToPower = wordingManager.wordings.headerConnectToPower {
            return customHeaderConnectToPower
        }
        
        return I18n.pairingBluetoothDeviceFoundHeaderConnectToPower
    }
    
    private func explainedReadyToPair() -> String {
        if let customExplainedReadyToPair = wordingManager.wordings.explainedReadyToPair {
            return customExplainedReadyToPair
        }
        
        return I18n.pairingBluetoothDeviceFoundExplainedReadyToPair
    }
}
