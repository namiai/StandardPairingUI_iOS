// Copyright (c) nami.ai

import I18n
import Lottie
import NamiSharedUIElements
import SharedAssets
import SwiftUI
import Tomonari

public struct InitialScreenView: View {
    // MARK: Lifecycle

    public init(viewModel: InitialScreen.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        NamiTopNavigationScreen(
            title: wordingManager.wordings.positioningNavigationTitle,
            colorOverride: themeManager.selectedTheme.navigationBarColor
        ) {
            VStack {
                mainContent()
                    .padding(.horizontal)
            }
            .background(colors.backgroundDefaultSecondary)
        } bottomButtonsGroup: {
            Button(wordingManager.wordings.nextButton) {
                viewModel.send(.howToPositionTapped)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.vertical)
            .anyView
        }
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @ObservedObject var viewModel: InitialScreen.ViewModel
    @Environment(\.colors) var colors: Colors

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager

    private func mainContent() -> some View {
        VStack(alignment: .center) {
            Text(wordingManager.wordings.widarInfoTitle, font: themeManager.selectedTheme.headline3).namiFillWidth(alignment: .center)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("∙")
                        .frame(width: 20, height: 20)
                        .foregroundColor(colors.textDefaultPrimary)
                    Text(wordingManager.wordings.widarInfoMustOptimisePosition, font: themeManager.selectedTheme.paragraph1)
                        .namiFillWidth()
                        .foregroundColor(colors.textDefaultPrimary)
                }
                HStack(alignment: .top) {
                    Text("∙")
                        .frame(width: 20, height: 20)
                        .foregroundColor(colors.textDangerPrimary)
                    Text(wordingManager.wordings.widarInfoAvoidMovingWhenOptimized, font: themeManager.selectedTheme.paragraph1)
                        .namiFillWidth()
                        .foregroundColor(colors.textDangerPrimary)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
