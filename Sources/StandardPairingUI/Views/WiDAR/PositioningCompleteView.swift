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

    public var body: some View {
        NamiTopNavigationScreen(title: I18n.Widar.headerTitle, largeTitle: I18n.Widar.Position.title, contentBehavior: .fixed) {
            VStack {
                VStack {
                    AnimationView(animation: \.widarPositioningDone)
                        .padding(.vertical)
                    Text(I18n.Widar.Success.title, font: .headline3).fillWidth(alignment: .center)
                    Text(I18n.Widar.Success.contentMessage(viewModel.state.deviceName), font: .paragraph1).fillWidth(alignment: .center)
                }
                .padding(.horizontal)

                Spacer()
            }
        } bottomButtonsGroup: {
            Button(I18n.Widar.Success.doneButton) {
                viewModel.send(.confirmPositioningComplete)
            }
            .buttonStyle(NamiActionButtonStyle())
            .padding(.vertical)
        }
    }
}
