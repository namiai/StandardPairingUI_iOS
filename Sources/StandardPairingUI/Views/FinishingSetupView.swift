// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

// MARK: - FinishingSetupView

public struct FinishingSetupView: View {
    public init(title: String? = nil) {
        self.title = title ?? ""
    }
    
    public var body: some View {
        DeviceSetupScreen(title: self.title.isEmpty ? wordingManager.wordings.pairingNavigationBarTitle : self.title) {
            VStack {
                Text(wordingManager.wordings.finishingSetupHeader)
                    .font(themeManager.selectedTheme.headline3)
                    .foregroundColor(themeManager.selectedTheme.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                Text(wordingManager.wordings.gameOfPongText)
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
        }
        .ignoresSafeArea(.keyboard)
        .allowSwipeBackNavigation(false)
    }
    
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager
    
    private var title: String
}
