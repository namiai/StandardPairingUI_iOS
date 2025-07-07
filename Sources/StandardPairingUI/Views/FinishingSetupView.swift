// Copyright (c) nami.ai

import NamiI18n
import SwiftUI
import Tomonari

// MARK: - FinishingSetupView

public struct FinishingSetupView: View {
    public init(title: String? = nil) {
        self.title = title ?? ""
    }
    
    public var body: some View {
        DeviceSetupScreen(title: navigationBarTitle()) {
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
    
    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager
    
    private var title: String
    
    private func navigationBarTitle() -> String {
        if isSettingUpKit(wordings: wordingManager.wordings) {
            return kitName(wordings: wordingManager.wordings)
        }
        
        return self.title.isEmpty ? I18n.pairingDeviceSetupNavigationTitle : self.title
    }
}
