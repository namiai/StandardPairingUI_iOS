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
        VStack(alignment: .center) {
            Text(wordingManager.wordings.widarInfoTitle, font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("∙")
                        .frame(width: 20, height: 20)
                    Text(wordingManager.wordings.widarInfoMustOptimisePosition, font: themeManager.selectedTheme.paragraph1).fillWidth()
                }
                HStack(alignment: .top) {
                    Text("∙")
                        .frame(width: 20, height: 20)
                        .foregroundColor(themeManager.selectedTheme.redAlert4)
                    Text(wordingManager.wordings.widarInfoAvoidMovingWhenOptimized, font: themeManager.selectedTheme.paragraph1).fillWidth().foregroundColor(themeManager.selectedTheme.redAlert4)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
