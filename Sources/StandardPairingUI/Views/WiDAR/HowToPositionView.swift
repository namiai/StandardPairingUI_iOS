// Copyright (c) nami.ai

import Lottie
import SharedAssets
import SwiftUI
import Tomonari
import I18n
import NamiSharedUIElements

public struct HowToPositionView: View {
    // MARK: Lifecycle

    public init(viewModel: HowToPosition.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations

    @ObservedObject var viewModel: HowToPosition.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager

    public var body: some View {
        DeviceSetupScreen(title: I18n.Widar.headerTitle) {
            mainContent()
                .padding()
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.wantToDismiss)
            }
        } bottomButtonsGroup: {
            Button(I18n.Widar.Recommendations.buttonText) {
                viewModel.send(.startPositioningTapped)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.vertical)
            .anyView
        }
    }

    // MARK: Private

    private func mainContent() -> some View {
        VStack {
            AnimationView(animation: \.widarPositioningRec)

            Text(I18n.Widar.Recommendations.title, font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
            Text("∙ \(I18n.Widar.Recommendations.infoAttachBase)", font: themeManager.selectedTheme.paragraph1).fillWidth()
            Text("∙ \(I18n.Widar.Recommendations.infoWireOnBack)", font: themeManager.selectedTheme.paragraph1).fillWidth()
            Text("∙ \(I18n.Widar.Recommendations.infoKeepAreaClear)", font: themeManager.selectedTheme.paragraph1).fillWidth()

            Spacer()
        }
    }
}
