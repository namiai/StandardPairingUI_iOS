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

    public var body: some View {
        DeviceSetupScreen(title: I18n.Widar.headerTitle) {
            mainContent()
                .padding(.horizontal)
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.dismissSelf)
            }
        } bottomButtonsGroup: {
            Button(I18n.Widar.Info.buttonText) {
                viewModel.send(.howToPositionTapped)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.vertical)
            .anyView
        }
    }

    // MARK: Private

    private func mainContent() -> some View {
        VStack {
            Text(I18n.Widar.Info.title, font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
            Text("∙ \(I18n.Widar.Info.infoMustOptimisePosition)", font: themeManager.selectedTheme.paragraph1).fillWidth()
            Text("∙ \(I18n.Widar.Info.infoAvoidMovingWhenOptimized)", font: themeManager.selectedTheme.paragraph1).fillWidth().foregroundColor(themeManager.selectedTheme.redAlert4)
            Spacer()
        }
    }
}
