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

    public var body: some View {
        NamiTopNavigationScreen(title: I18n.Widar.headerTitle, contentBehavior: .fixed) {
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
            .buttonStyle(NamiActionButtonStyle())
            .padding(.vertical)
        }
    }

    // MARK: Private

    private func mainContent() -> some View {
        VStack {
            Text(I18n.Widar.Info.title, font: .headline3).fillWidth(alignment: .center)
            Text("∙ \(I18n.Widar.Info.infoMustOptimisePosition)", font: .paragraph1).fillWidth()
            Text("∙ \(I18n.Widar.Info.infoAvoidMovingWhenOptimized)", font: .paragraph1).fillWidth().foregroundColor(colors.redAlert4)
            Spacer()
        }
    }
}
