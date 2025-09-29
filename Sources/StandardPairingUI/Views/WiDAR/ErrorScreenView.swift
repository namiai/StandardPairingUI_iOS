// Copyright (c) nami.ai

import I18n
import NamiSharedUIElements
import SharedAssets
import SwiftUI
import Tomonari

public struct ErrorScreenView: View {
    // MARK: Lifecycle

    public init(viewModel: ErrorScreen.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        NamiTopNavigationScreen(
            title: wordingManager.wordings.positioningNavigationTitle,
            colorOverride: themeManager.selectedTheme.navigationBarColor
        ) {
            VStack {
                Spacer()
                VStack(alignment: .center) {
                    Icons.warning
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 128)
                        .foregroundColor(colors.iconDangerPrimary)
                    Text(wordingManager.wordings.positioningErrorTitle)
                        .font(themeManager.selectedTheme.headline3)
                        .lineLimit(2)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(wordingManager.wordings.deviceNotFoundMessage)
                        .font(themeManager.selectedTheme.paragraph1)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 2)
                        .lineLimit(4)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .padding(.top)
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.cancelPositioning)
            }
        } bottomButtonsGroup: {
            VStack {
                Button(wordingManager.wordings.retryPositioningButton) {
                    viewModel.send(.retryPositioning)
                }
                .buttonStyle(themeManager.selectedTheme.primaryActionButtonStyle)
                .anyView
                Button(wordingManager.wordings.exitPositioningButton) {
                    viewModel.send(.cancelPositioning)
                }
                .buttonStyle(themeManager.selectedTheme.secondaryActionButtonStyle)
                .anyView
            }
        }
        .ignoresSafeArea(.keyboard)
    }

    // MARK: Internal

    @ObservedObject var viewModel: ErrorScreen.ViewModel

    // MARK: Private

    @Environment(\.themeManager) private var themeManager
    @Environment(\.wordingManager) private var wordingManager
    @Environment(\.colors) private var colors: Colors
}
