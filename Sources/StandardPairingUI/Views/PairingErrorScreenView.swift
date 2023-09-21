// Copyright (c) nami.ai

import Tomonari
import SwiftUI
import I18n

// MARK: - PairingErrorScreenView

public struct PairingErrorScreenView: View {
    // MARK: Lifecycle
    
    public init(viewModel: PairingErrorScreen.ViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: PairingErrorScreen.ViewModel
    
    public var body: some View {
        DeviceSetupScreen {
            Spacer()
            Image("Warning")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text(I18n.Pairing.ErrorScreen.errorOccurredTitle.localized)
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
    
    // MARK: Private
    
    private func buttonForAction(at index: Int) -> some View {
        let action = viewModel.state.actions[index]
        return Button(titleForAction(action).localized, action: { viewModel.send(event: .didChooseAction(action)) })
            .disabled(viewModel.state.chosenAction != nil)
            .buttonStyle(NamiActionButtonStyle(rank: index == 0 ? .primary : .secondary))
    }
    
    private func titleForAction(_ action: Pairing.ActionOnError) -> LocalizedKey {
        switch action {
        case .tryAgain:
            return I18n.Pairing.ErrorScreen.actionTryAgain
        case .restart:
            return I18n.Pairing.ErrorScreen.actionRestart
        case .ignore:
            return I18n.Pairing.ErrorScreen.actionIgnore
        }
    }
}
