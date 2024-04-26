// Copyright (c) nami.ai

import I18n
import SwiftUI
import Tomonari

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
            Image("warning-alert")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            // TODO: Switch to use `viewModel.state.error.errorMessageTitle` when there's the values for it in I18n but not hardcoded strings.
            // The preparation is done in `PairingErrorsExtensions`.
            Text(viewModel.state.error.errorMessageTitle)
                .font(NamiTextStyle.headline3.font)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
            Text(viewModel.state.error.localizedDescription)
                .font(NamiTextStyle.paragraph1.font)
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

    // MARK: Private

    private func buttonForAction(at index: Int) -> some View {
        let actions = viewModel.state.actions
        let action = actions[index]
        return Button(titleForAction(action), action: { viewModel.send(event: .didChooseAction(action)) })
            .disabled(viewModel.state.chosenAction != nil)
            .buttonStyle(NamiActionButtonStyle(rank: index == 0 ? .primary : .secondary))
            .padding(.bottom, index == actions.count-1 ? NamiActionButtonStyle.ConstraintLayout.BottomToSuperView : NamiActionButtonStyle.ConstraintLayout.BottomToNextButton)
    }

    private func titleForAction(_ action: Pairing.ActionOnError) -> String {
        switch action {
        case .tryAgain:
            return I18n.Pairing.Errors.actionTryAgain
        case .restart:
            if case let .underlying(error) = viewModel.state.error {
                if let error = error as? PairingMachineError, case .notSupportDeviceType(_) = error {
                    return I18n.Pairing.Errors.actionRestartSetup
                }
            } 
            
            return I18n.Pairing.Errors.actionRestart
        case .ignore:
            return I18n.Pairing.Errors.actionIgnore
        case .exit:
            return I18n.Pairing.Errors.actionExitSetup
        }
    }
}
