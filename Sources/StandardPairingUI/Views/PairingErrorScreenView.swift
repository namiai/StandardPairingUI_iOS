// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari
import NamiSharedUIElements

// MARK: - PairingErrorScreenView

public struct PairingErrorScreenView: View {
    // MARK: Lifecycle

    public init(viewModel: PairingErrorScreen.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public

    public var body: some View {
        DeviceSetupScreen {
            Spacer()
            Image("Warning")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            // TODO: Switch to use `viewModel.state.error.errorMessageTitle` when there's the values for it in I18n but not hardcoded strings.
            // The preparation is done in `PairingErrorsExtensions`.
            Text(I18n.Pairing.Errors.errorOccurredTitle)
                .font(themeManager.selectedTheme.headline3)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
            Text(viewModel.state.error.localizedDescription)
                .font(themeManager.selectedTheme.paragraph1)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                .padding(.top, 4)
            Spacer()
            VStack {
                if viewModel.state.actions.isEmpty == false {
                    ForEach(0..<viewModel.state.actions.count, id: \.self, content: buttonForAction)
                }
            }
            .padding()
        }
    }

    // MARK: Internal

    @ObservedObject var viewModel: PairingErrorScreen.ViewModel
    @EnvironmentObject private var themeManager: ThemeManager

    // MARK: Private

    private func buttonForAction(at index: Int) -> some View {
        let action = viewModel.state.actions[index]
        let style = index == 0 ? themeManager.selectedTheme.primaryActionButtonStyle : themeManager.selectedTheme.secondaryActionButtonStyle 
        return Button(titleForAction(action), action: { viewModel.send(event: .didChooseAction(action)) })
            .disabled(viewModel.state.chosenAction != nil)
            .buttonStyle(style)
            .anyView
    }

    private func titleForAction(_ action: Pairing.ActionOnError) -> String {
        switch action {
        case .tryAgain:
            return I18n.Pairing.Errors.actionTryAgain
        case .restart:
            return I18n.Pairing.Errors.actionRestart
        case .ignore:
            return I18n.Pairing.Errors.actionIgnore
        }
    }
}
