// Copyright (c) nami.ai

import I18n
import NamiSharedUIElements
import SharedAssets
import SwiftUI
import Tomonari

// MARK: - FinishingSetupView

public struct FinishingSetupView: View {
    // MARK: Lifecycle

    public init(title: String? = nil) {
        self.title = title ?? ""
    }

    // MARK: Public

    public var body: some View {
        NamiTopNavigationScreen(
            title: navigationBarTitle(),
            colorOverride: themeManager.selectedTheme.navigationBarColor,
            mainContent: {
                VStack {
                    Text(wordingManager.wordings.finishingSetupHeader)
                        .font(themeManager.selectedTheme.headline3)
                        .foregroundColor(colors.textDefaultPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.horizontal, .top])
                    Text(wordingManager.wordings.gameOfPongText)
                        .font(themeManager.selectedTheme.paragraph1)
                        .foregroundColor(colors.textDefaultPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Spacer()
                    PongView()
                        .frame(maxHeight: 300)
                        .padding()
                }
                .padding(.bottom)
            }
        )
        .ignoresSafeArea(.keyboard)
        .namiAllowSwipeBackNavigation(false)
    }

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager
    @Environment(\.colors) private var colors

    private var title: String

    private func navigationBarTitle() -> String {
        if isSettingUpKit(wordings: wordingManager.wordings) {
            return kitName(wordings: wordingManager.wordings)
        }

        return title.isEmpty ? I18n.pairingDeviceSetupNavigationTitle : title
    }
}
