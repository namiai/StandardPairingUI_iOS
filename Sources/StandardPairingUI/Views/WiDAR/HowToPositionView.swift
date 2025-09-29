// Copyright (c) nami.ai

import I18n
import Lottie
import NamiSharedUIElements
import SharedAssets
import SwiftUI
import Tomonari

public struct HowToPositionView: View {
    // MARK: Lifecycle

    public init(viewModel: HowToPosition.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        NamiTopNavigationScreen(
            title: wordingManager.wordings.positioningNavigationTitle,
            colorOverride: themeManager.selectedTheme.navigationBarColor
        ) {
            mainContent()
                .padding()
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.wantToDismiss)
            }
        } bottomButtonsGroup: {
            Button(wordingManager.wordings.startPositioningButton) {
                viewModel.send(.startPositioningTapped)
            }
            .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
            .padding(.vertical)
            .anyView
        }
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @Environment(\.animations) var animations: Animations

    @ObservedObject var viewModel: HowToPosition.ViewModel

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager

    private func mainContent() -> some View {
        VStack(alignment: .center) {
            AnimationView(animation: \.widarPositioningRec)

            Text(wordingManager.wordings.recommendationsTitle, font: themeManager.selectedTheme.headline3).fillWidth(alignment: .center)
                .padding(.vertical)

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Icons.greenTick
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(wordingManager.wordings.recommendationsInfoAttachBase, font: themeManager.selectedTheme.paragraph1).fillWidth()
                }
                HStack(alignment: .top) {
                    Icons.greenTick
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(wordingManager.wordings.recommendationsInfoWireOnBack, font: themeManager.selectedTheme.paragraph1).fillWidth()
                }
                HStack(alignment: .top) {
                    Icons.greenTick
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(wordingManager.wordings.recommendationsInfoKeepAreaClear, font: themeManager.selectedTheme.paragraph1).fillWidth()
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}
