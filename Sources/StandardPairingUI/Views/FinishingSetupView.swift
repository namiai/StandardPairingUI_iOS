// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - FinishingSetupView

public struct FinishingSetupView: View {
    public init() {
        
    }
    
    public var body: some View {
        DeviceSetupScreen(title: titleWording()) {
            VStack {
                Text(finishingSetupHeader())
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                Text(gameOfPongText())
                    .font(themeManager.selectedTheme.paragraph1)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Spacer()
                PongView()
                    .frame(maxHeight: 300)
                    .padding()
            }
            .padding(.bottom)
            .ignoresSafeArea(.keyboard)
        }
    }
    
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.Pairing.DeviceSetup.navigagtionTitle
    }
    
    private func finishingSetupHeader() -> String {
        if let customScanning = wordingManager.wordings.finishingSetupHeader {
            return customScanning
        }
        
        return I18n.Pairing.FinishingSetup.header
    }
    
    private func gameOfPongText() -> String {
        if let customScanning = wordingManager.wordings.gameOfPongText {
            return customScanning
        }
        
        return I18n.Pairing.FinishingSetup.gameOfPong
    }
}
