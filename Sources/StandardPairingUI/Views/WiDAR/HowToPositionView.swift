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

    public var body: some View {
        NamiTopNavigationScreen(title: I18n.Widar.headerTitle, contentBehavior: .fixed) {
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
            .buttonStyle(NamiActionButtonStyle())
            .padding(.vertical)
        }
    }

    // MARK: Private

    private func mainContent() -> some View {
        VStack {
            AnimationView(animation: \.widarPositioningRec)

            Text(I18n.Widar.Recommendations.title, font: .headline3).fillWidth(alignment: .center)
            Text("∙ \(I18n.Widar.Recommendations.infoAttachBase)", font: .paragraph1).fillWidth()
            Text("∙ \(I18n.Widar.Recommendations.infoWireOnBack)", font: .paragraph1).fillWidth()
            Text("∙ \(I18n.Widar.Recommendations.infoKeepAreaClear)", font: .paragraph1).fillWidth()

            Spacer()
        }
    }
}
