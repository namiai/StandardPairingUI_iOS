// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - FinishingSetupView

public struct FinishingSetupView: View {
    public var body: some View {
        DeviceSetupScreen {
            VStack {
                Text(I18n.Pairing.FinishingSetup.header)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                Text(I18n.Pairing.FinishingSetup.gameOfPong)
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
        .allowSwipeBackNavigation(false)
    }
    
    @EnvironmentObject private var themeManager: ThemeManager
}
