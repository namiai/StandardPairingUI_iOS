// Copyright (c) nami.ai

import NamiSharedUIElements
import SwiftUI
import Tomonari
import I18n

public struct ErrorScreenView: View {
    // MARK: Lifecycle

    public init(viewModel: ErrorScreen.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Internal

    @ObservedObject var viewModel: ErrorScreen.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var wordingManager: WordingManager

    public var body: some View {
        DeviceSetupScreen(title: wordingManager.wordings.positioningNavigationTitle) {
            VStack {
                Spacer()
                VStack(alignment: .center) {
                    Image("Warning", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 128)
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
}
