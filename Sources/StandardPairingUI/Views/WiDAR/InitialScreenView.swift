// Copyright (c) nami.ai

import Lottie
import SharedAssets
import SwiftUI
import Tomonari
import I18n
import NamiSharedUIElements

public struct InitialScreenView: View {
    // MARK: Lifecycle

    public init(viewModel: InitialScreen.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @ObservedObject var viewModel: InitialScreen.ViewModel
    @Environment(\.colors) var colors: Colors
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    public var body: some View {
        DeviceSetupScreen(title: wordingManager.wordings.positioningNavigationTitle) {
            mainContent()
                .padding(.horizontal)
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.dismissSelf)
            }
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

    // MARK: Private

    private func mainContent() -> some View {
        VStack {
            Text(wordingManager.wordings.widarInfoMustOptimisePosition, font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
            Text("∙ \(wordingManager.wordings.widarInfoMustOptimisePosition)", font: themeManager.selectedTheme.paragraph1).fillWidth()
            Text("∙ \(wordingManager.wordings.widarInfoAvoidMovingWhenOptimized)", font: themeManager.selectedTheme.paragraph1).fillWidth().foregroundColor(themeManager.selectedTheme.redAlert4)
            Spacer()
        }
    }
}
