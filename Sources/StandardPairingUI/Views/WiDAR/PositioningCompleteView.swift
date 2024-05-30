// Copyright (c) nami.ai

import SwiftUI
import Tomonari
import I18n
import NamiSharedUIElements

public struct PositioningCompleteView: View {
    // MARK: Lifecycle

    public init(viewModel: PositioningComplete.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations

    @ObservedObject var viewModel: PositioningComplete.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager

    public var body: some View {
        DeviceSetupScreen(title: I18n.Widar.headerTitle) {
            VStack {
                VStack {
                    AnimationView(animation: \.widarPositioningDone)
                        .padding(.vertical)
                    Text(I18n.Widar.Success.title, font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
                    Text(I18n.Widar.Success.contentMessage(viewModel.state.deviceName), font: themeManager.selectedTheme.paragraph1).fillWidth(alignment: .center)
                }
                .padding(.horizontal)

                Spacer()
            }
        } bottomButtonsGroup: {
            Button(I18n.Widar.Success.doneButton) {
                viewModel.send(.confirmPositioningComplete)
            }
            .font(themeManager.selectedTheme.headline5)
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.vertical)
            .anyView
        }
    }
}
