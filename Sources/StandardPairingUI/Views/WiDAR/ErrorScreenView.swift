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

    public var body: some View {
        NamiTopNavigationScreen(title: I18n.Widar.headerTitle, contentBehavior: .fixed) {
            VStack {
                Spacer()
                Image("Warning")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text(I18n.Widar.Error.title)
                    .font(NamiTextStyle.headline3.font)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                Text(I18n.Widar.Error.deviceNotFoundMessage)
                    .font(NamiTextStyle.paragraph1.font)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    .padding(.top, 4)
                Spacer()
            }
            .padding(.top)
        } leadingButtonsGroup: {
            NamiNavBackButton {
                viewModel.send(.cancelPositioning)
            }
        } bottomButtonsGroup: {
            VStack {
                Button(I18n.Widar.Error.retryButton) {
                    viewModel.send(.retryPositioning)
                }
                .buttonStyle(NamiActionButtonStyle())
                Button(I18n.Widar.Error.exitButton) {
                    viewModel.send(.cancelPositioning)
                }
                .buttonStyle(NamiActionButtonStyle(rank: .secondary))
            }
            .padding()
        }
    }
}
