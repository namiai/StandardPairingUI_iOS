// Copyright (c) nami.ai

import I18n
import NamiSharedUIElements
import SwiftUI
import Tomonari

@MainActor
public struct PositioningCompleteView: View {
    // MARK: Lifecycle

    public init(viewModel: PositioningComplete.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        NamiTopNavigationScreen(
            title: wordingManager.wordings.positioningNavigationTitle,
            colorOverride: themeManager.selectedTheme.navigationBarColor
        ) {
            VStack {
                VStack {
                    AnimationView(animation: \.widarPositioningDone)
                        .padding(.vertical)
                    Text(wordingManager.wordings.successTitle, font: themeManager.selectedTheme.headline3).namiFillWidth(alignment: .center)
                    Text(wordingManager.wordings.sucessContentMessage(deviceName: viewModel.state.deviceName), font: themeManager.selectedTheme.paragraph1).namiFillWidth(alignment: .center)
                }
                .padding(.horizontal)

                Spacer()
            }
            .namiNavigationPopGestureDisabled(true)
        } bottomButtonsGroup: {
            Button(wordingManager.wordings.doneButton) {
                viewModel.send(.confirmPositioningComplete)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.vertical)
            .anyView
        }
        .namiAllowSwipeBackNavigation(false)
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations

    @ObservedObject var viewModel: PositioningComplete.ViewModel

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager
}
