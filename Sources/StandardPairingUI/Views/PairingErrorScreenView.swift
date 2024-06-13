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
        DeviceSetupScreen(title: titleWording()) {
            Spacer()
            Image("Warning")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            // TODO: Switch to use `viewModel.state.error.errorMessageTitle` when there's the values for it in I18n but not hardcoded strings.
            // The preparation is done in `PairingErrorsExtensions`.
            Text(I18n.Pairing.Errors.errorOccurredTitle)
                .font(themeManager.selectedTheme.headline3)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
            Text(viewModel.state.error.localizedDescription)
                .font(themeManager.selectedTheme.paragraph1)
                .foregroundColor(themeManager.selectedTheme.primaryBlack)
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
    @EnvironmentObject private var wordingManager: WordingManager

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
            return tryAgainActionTitle()
        case .restart:
            return restartActionTitle()
        case .ignore:
            return ignoreActionTitle()
        }
    }
    
    private func titleWording() -> String { 
        if let customNavigationTitle = wordingManager.wordings.pairingNavigationBarTitle {
            return customNavigationTitle
        }
        
        return I18n.Pairing.DeviceSetup.navigagtionTitle
    }
    
    private func errorOccurredTitle() -> String {
        if let customScanning = wordingManager.wordings.errorOccurredTitle {
            return customScanning
        }
        
        return I18n.Pairing.Errors.errorOccurredTitle
    }
    
    private func tryAgainActionTitle() -> String {
        if let customScanning = wordingManager.wordings.tryAgainActionTitle {
            return customScanning
        }
        
        return I18n.Pairing.Errors.actionTryAgain
    }
    
    private func restartActionTitle() -> String {
        if let customScanning = wordingManager.wordings.restartActionTitle {
            return customScanning
        }
        
        return I18n.Pairing.Errors.actionRestart
    }
    
    private func ignoreActionTitle() -> String {
        if let customScanning = wordingManager.wordings.ignoreActionTitle {
            return customScanning
        }
        
        return I18n.Pairing.Errors.actionIgnore
    }
}
